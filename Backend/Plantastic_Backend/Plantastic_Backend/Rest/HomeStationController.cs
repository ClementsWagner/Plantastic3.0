using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.Rest
{
    [Route("backend/[controller]")]
    [ApiController]
    internal class HomeStationController: ControllerBase
    {
        private readonly HomeStationManager manager;

        public HomeStationController(HomeStationManager manager)
        {
            this.manager = manager;
        }

        [HttpPost]
        public async Task<ActionResult> AddHomeStation(HomeStation homeStation)
        {
            try
            {
                await manager.AddHomeStation(homeStation);
                return Created(string.Empty, homeStation);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new ProblemDetails
                {
                    //Type = "https://",
                    Title = "Invalid homeStation",
                    Detail = ex.Message,
                });
            }
        }

        [HttpPut]
        public async Task<ActionResult> UpdateHomeStation(HomeStation homeStation)
        {
            return await manager.UpdateHomeStation(homeStation) ? NoContent() : NotFound();
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteHomeStation(int id)
        {
            return await manager.RemoveHomeStation(id) ? NoContent() : NotFound();
        }
    }
}
