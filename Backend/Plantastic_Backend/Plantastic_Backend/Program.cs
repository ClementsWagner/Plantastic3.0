using Plantastic_Backend.DB;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers(options =>
{
    options.OutputFormatters.RemoveType<SystemTextJsonOutputFormatter>();
    options.OutputFormatters.Add(new SystemTextJsonOutputFormatter(new JsonSerializerOptions(JsonSerializerDefaults.Web)
    {
        ReferenceHandler = ReferenceHandler.IgnoreCycles,
    }));
});
builder.Services.AddDbContext<PlantasticContext>(
    options => options.UseSqlServer(builder.Configuration["ConnectionStrings:DefaultConnection"]))
    .AddDatabaseDeveloperPageExceptionFilter();
builder.Services.AddScoped<HomeStationManager>();
builder.Services.AddScoped<SensorManager>();
builder.Services.AddScoped<UserManager>();
builder.Services.AddHealthChecks().AddDbContextCheck<PlantasticContext>();

// Configure the HTTP request pipeline.
var app = builder.Build();
app.UseCors(b => b.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin());
app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();
app.UseHealthChecks("/health");
app.Run();
