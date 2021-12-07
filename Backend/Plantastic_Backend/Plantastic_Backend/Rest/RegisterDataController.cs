using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.Rest
{
    [Route("backend/[controller]")]
    [ApiController]
    internal class RegisterDataController: ControllerBase
    {
        private readonly RegisterDataManager manager;

        public RegisterDataController(RegisterDataManager manager)
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
    }
}
