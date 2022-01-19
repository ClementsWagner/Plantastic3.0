using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using System.Security.Cryptography;
using Plantastic_Backend.DB;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.DB
{
    public class UserManager
    {
        private readonly PlantasticContext context;

        public UserManager(PlantasticContext context)
        {
            this.context = context;
        }

        public async Task AddUser(User user)
        {
            byte[] salt = new byte[128 / 8];
            using (var rngCsp = new RNGCryptoServiceProvider())
            {
                rngCsp.GetNonZeroBytes(salt);
            }
            user.Salt = salt;

            string hashed = Convert.ToBase64String(KeyDerivation.Pbkdf2(
                password: user.Password,
                salt: salt,
                prf: KeyDerivationPrf.HMACSHA256,
                iterationCount: 100000,
                numBytesRequested: 256 / 8));
            user.Password = hashed;

            context.Users.Add(user);
            await context.SaveChangesAsync();
        }

        public async Task<bool> RemoveUser(int id)
        {
            var user = await context.Users.FirstOrDefaultAsync(u => u.Id == id);
            if (user == null)
                return false;

            context.Users.Remove(user);
            await context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> UpdateUser(User user)
        {
            if (user == null)
                return false;

            context.Users.Update(user);
            await context.SaveChangesAsync();

            return true;
        }

        public async Task<UserDTO> GetUser(int id)
        {
            try
            {
                User user = await context.Users.Where(h => h.Id == id).FirstOrDefaultAsync();
                return new UserDTO(user.Id, user.Email);
            }
            catch
            {
                return null;
            }
        }

        public async Task<bool> CheckPW(int id, string passwort)
        {
            try
            {
                User user = await context.Users.Where(h => h.Id == id).FirstOrDefaultAsync();
                string hased = Convert.ToBase64String(KeyDerivation.Pbkdf2(
                password: passwort,
                salt: user.Salt,
                prf: KeyDerivationPrf.HMACSHA256,
                iterationCount: 100000,
                numBytesRequested: 256 / 8));

                if (hased.Equals(user.Password))
                {
                    return true;
                }
                return false;
            }
            catch
            {
                return false;
            }
        }
    }
}
