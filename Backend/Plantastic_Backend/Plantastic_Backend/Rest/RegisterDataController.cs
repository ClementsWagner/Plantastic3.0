using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Plantastic_Backend.Rest
{
    [Route("backend/RegisterData")]
    [ApiController]
    public class RegisterDataController : ControllerBase
    {
        private readonly HomeStationManager manager;

        public RegisterDataController(HomeStationManager manager)
        {
            this.manager = manager;
        }

        [HttpPost]
        public async Task<ActionResult> AddRegisterData(RegisterData registerData)
        {
            try
            {
                await manager.AddRegisterData(registerData);
                return Created(string.Empty, registerData);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new ProblemDetails
                {
                    //Type = "https://",
                    Title = "Invalid registerData",
                    Detail = ex.Message,
                });
            }
        }

        [HttpPut]
        public async Task<ActionResult> UpdateRegisterData(RegisterData registerData)
        {
            return await manager.UpdateRegisterData(registerData) ? NoContent() : NotFound();
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteRegisterData(int id)
        {
            return await manager.RemoveRegisterData(id) ? NoContent() : NotFound();
        }

        [HttpGet("{id}")]
        public async Task<UserDTO> GetRegisterData(int id)
        {
            return await manager.GetRegisterData(id);          
        }
    }
}
