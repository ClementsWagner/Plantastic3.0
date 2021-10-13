import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

const AUTH0_DOMAIN = 'auth-dev.plantastic.at/auth/realms/plantastic';
const AUTH0_CLIENT_ID = 'plantastic-app';

const AUTH0_REDIRECT_URI = 'com.plantastic://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

class AuthenticationService extends ChangeNotifier {
  bool _isLoggedIn = false;
  TokenResponse _token;

  Future<String> get token async {
    if (_token == null || _token.expiresAt.compareTo(DateTime.now()) < 1 && _isLoggedIn) {
      await refreshToken();
    }
    return _token?.accessToken;
  }

  bool get isLoggedIn => _isLoggedIn;

  var uri = Uri.parse('https://' + AUTH0_DOMAIN);
  var clientId = AUTH0_CLIENT_ID;
  var scopes = List<String>.of(['openid', 'profile']);
  var port = 4200;

  Future<Issuer> get issuer async => await Issuer.discover(uri);

  Future<Client> get client async => new Client(await issuer, clientId);

  Future<UserInfo> get userInfo async => _credentialVariable.getUserInfo();

  Authenticator _authenticatorVariable;
  Credential _credentialVariable;

  Future urlLauncher(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future urlLauncherBackground(String url) async {
    if (await canLaunch(url)) {
      await http.get(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool> refreshToken() async {
    var storedRefreshToken;
    try{
      storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    }catch(e){}
    if (storedRefreshToken == null || storedRefreshToken == "")
      return Future.value(false);

    try {
      _credentialVariable = (await client).createCredential(
        accessToken: null,
        tokenType: await secureStorage.read(key: "tokenType"),
        refreshToken: await secureStorage.read(key: "refresh_token"),
        idToken: await secureStorage.read(key: "idToken"),
      );

      _credentialVariable.validateToken(
          validateClaims: true, validateExpiry: true);
      var token = await _credentialVariable.getTokenResponse();
      await _saveToken(token);
      _token = token;
      _isLoggedIn = true;
      return Future.value(true);
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      await logoutAction();
      return Future.value(false);
    }
  }

  Future<bool> loginAction() async {
    try {
      _authenticatorVariable = new Authenticator(
        await client,
        scopes: scopes,
        port: port,
        urlLancher: urlLauncher,
      );
      //if there is a "you can now close this window page" delete it in openid_client_id line 61
      _credentialVariable = await _authenticatorVariable.authorize().then((value) {
        _authenticatorVariable.cancel();
        return value;
      });

      closeWebView();

      var token = await _credentialVariable.getTokenResponse();
      _token = token;
      print(token);
      await _saveToken(token);
      _isLoggedIn = true;
      return Future.value(true);
    } catch (e) {
      await logoutAction();
      return Future.value(false);
    }
  }

  Future<bool> logoutAction() async {
    try {
      var url = _credentialVariable.generateLogoutUrl();
      await urlLauncherBackground(url.toString());
      _token = null;
      _credentialVariable = null;
      _authenticatorVariable = null;
      _isLoggedIn = false;
      await _clearToken();
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    } finally {
      //notifyListeners();
    }
  }

  Future _saveToken(TokenResponse tokenResponse) async {
    await secureStorage.write(
        key: 'access_token', value: tokenResponse.accessToken);
    await secureStorage.write(
        key: 'refresh_token', value: tokenResponse.refreshToken);
    await secureStorage.write(key: 'tokenType', value: tokenResponse.tokenType);
    await secureStorage.write(
        key: 'idToken', value: tokenResponse.idToken.toCompactSerialization());
  }

  Future _clearToken() async {
    await secureStorage.write(key: 'access_token', value: "");
    await secureStorage.write(key: 'refresh_token', value: "");
    await secureStorage.write(key: 'tokenType', value: "");
    await secureStorage.write(key: 'idToken', value: "");
  }
}
