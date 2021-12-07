using Plantastic_Backend.DB;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.DB
{
    internal class HomeStationManager
    {
        private readonly PlantasticContext context;

        public HomeStationManager(PlantasticContext context)
        {
            this.context = context;
        }

        public async Task AddHomeStation(HomeStation homeStation)
        {
            context.HomeStations.Add(homeStation);
            await context.SaveChangesAsync();
        }

        public async Task<bool> RemoveHomeStation(int id)
        {
            var homeStation = await context.HomeStations.FirstOrDefaultAsync(h => h.Id == id);
            if (homeStation == null)
                return false;

            context.HomeStations.Remove(homeStation);
            await context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> UpdateHomeStation(HomeStation homeStation)
        {
            if (homeStation == null)
                return false;

            context.HomeStations.Update(homeStation);
            await context.SaveChangesAsync();
            return true;
        }

        public async Task<HomeStation> GetHomeStation(int id)
        {
            return await context.HomeStations.FirstOrDefaultAsync(h => h.Id == id);
        }
       
    }
}
