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
    }
}
