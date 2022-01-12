using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.Rest
{
    [Route("backend/HomeStation")]
    [ApiController]
    public class HomeStationController : ControllerBase
    {
        private readonly HomeStationManager manager;

        public HomeStationController(HomeStationManager manager)
        {
            this.manager = manager;
        }

        [HttpPost("{id}")]
        public async Task<ActionResult> AddHomeStation(int id, [FromBody] HomeStation homeStation)
        {
            try
            {
                await manager.AddHomeStation(homeStation);
                await manager.AddRegisterData(new RegisterData()
                {
                    User = manager.GetCompleteUser(id).Result,
                    HomeStation = homeStation,
                    Notification = true
                });
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

        [HttpGet("{id}")]
        public async Task<IEnumerable<HomeStation>> GetAllHomeStation(int id)
        {
            return await manager.GetAllHomeStation(id);
        }

        /*[HttpGet("{id}")]
        public async Task<HomeStation> GetHomeStation(int id)
        {
            return await manager.GetHomeStation(id);
        }*/
    }
}
