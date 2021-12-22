using Plantastic_Backend.DB;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.DB
{
    public class HomeStationManager
    {
        private readonly PlantasticContext context;

        public HomeStationManager(PlantasticContext context)
        {
            this.context = context;
        }

        #region HomeStation
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
            return await context.HomeStations.Where(h => h.Id == id).FirstOrDefaultAsync();
        }

        public async Task<IEnumerable<HomeStation>> GetAllHomeStation(int id)
        {
            return (IEnumerable<HomeStation>)await context.RegisterDatas.Where(rd => rd.User.Id == id)
                .Join(context.HomeStations, data => data.HomeStation.Id, home => home.Id, (home, data) => home)
                .ToListAsync();
        }
        #endregion

        #region RegisterData
        public async Task AddRegisterData(RegisterData registerData)
        {
            context.RegisterDatas.Add(registerData);
            await context.SaveChangesAsync();
        }

        public async Task<bool> RemoveRegisterData(int id)
        {
            var registerData = await context.RegisterDatas.FirstOrDefaultAsync(r => r.Id == id);
            if (registerData == null)
                return false;

            context.RegisterDatas.Remove(registerData);
            await context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> UpdateRegisterData(RegisterData registerData)
        {
            if (registerData == null)
                return false;

            context.RegisterDatas.Update(registerData);
            await context.SaveChangesAsync();
            return true;
        }

        public async Task<UserDTO> GetRegisterData(int id)
        {
            return await context.RegisterDatas.Where(r => r.HomeStation.Id == id)
                .Select(r => new UserDTO(r.User.Id, r.User.Email)).FirstOrDefaultAsync();
        }
        #endregion

        public async Task<User> GetCompleteUser(int id)
        {
            return await context.Users.Where(r => r.Id == id).FirstOrDefaultAsync();
        }
    }
}
