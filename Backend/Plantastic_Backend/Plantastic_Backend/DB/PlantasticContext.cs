namespace Plantastic_Backend.DB;

    public class PlantasticContext: DbContext
    {
        public PlantasticContext(DbContextOptions<PlantasticContext> options) : base(options) { }

        public DbSet<HomeStation> HomeStations => Set<HomeStation>();
        public DbSet<User> Users => Set<User>();
        public DbSet<Sensor> Sensors => Set<Sensor>();
        public DbSet<SensorData> SensorDatas => Set<SensorData>();
        public DbSet<RegisterData> RegisterDatas => Set<RegisterData>();

        protected override void OnModelCreating(ModelBuilder builder)
        {
        }
    }

