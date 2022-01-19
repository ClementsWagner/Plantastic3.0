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

        [HttpDelete("{email}")]
        public async Task<ActionResult> DeleteUser(String email)
        {
            return await manager.RemoveUser(email) ? NoContent() : NotFound();
        }

         [HttpGet("{email}")]
         public async Task<UserDTO> GetUser(String email)
         {
                 return await manager.GetUser(email);        
         }

        [HttpPut("{email}")]
        public async Task<bool> CheckPW([FromRoute]String email, [FromBody]Passwort Passwort)
        {
            return await manager.CheckPW(email, Passwort.passwort);
        }
    }
}
