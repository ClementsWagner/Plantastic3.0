using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.Rest
{ 

    [Route("backend/User")]
    [ApiController]
    public class UserController: ControllerBase
    {
        private readonly UserManager manager;

        public UserController(UserManager manager)
        {
            this.manager = manager;
            Console.WriteLine(this.RouteData);
        }

        [HttpPost]
        public async Task<ActionResult> AddUser(User user)
        {
            try
            {
                await manager.AddUser(user);
                var userDto = new UserDTO(user.Id, user.Email);
                return Created(string.Empty, userDto);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new ProblemDetails
                {
                    //Type = "https://",
                    Title = "Invalid user",
                    Detail = ex.Message,
                });
            }
        }

        [HttpPut]
        public async Task<ActionResult> UpdateUser(User user)
        {
            return await manager.UpdateUser(user) ? NoContent() : NotFound();
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteUser(int id)
        {
            return await manager.RemoveUser(id) ? NoContent() : NotFound();
        }

        [HttpGet]
        public async Task<UserDTO> GetUser(int id)
        {
                return await manager.GetUser(id);        
        }
    }
}
