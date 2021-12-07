using Plantastic_Backend.DB;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.DB
{
    internal class RegisterDataManager
    {
        private readonly PlantasticContext context;

        public RegisterDataManager(PlantasticContext context)
        {
            this.context = context;
        }

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

        public async Task<RegisterData> GetRegisterData(int id)
        {
            return await context.RegisterDatas.FirstOrDefaultAsync(h => h.Id == id);
        }
    }
}
