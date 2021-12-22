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

        #region HomeStation
        [Route("HS/{id}")]
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

        [Route("HS")]
        [HttpPut]
        public async Task<ActionResult> UpdateHomeStation(HomeStation homeStation)
        {
            return await manager.UpdateHomeStation(homeStation) ? NoContent() : NotFound();
        }

        [Route("HS/{id}")]
        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteHomeStation([FromQuery] int id)
        {
            return await manager.RemoveHomeStation(id) ? NoContent() : NotFound();
        }

        [Route("HS/all/{id}")]
        [HttpGet("{id}")]
        public async Task<IEnumerable<HomeStation>> GetAllHomeStation([FromQuery] int user)
        {
            return await manager.GetAllHomeStation(user);
        }

        /*[Route("HS/{id}")]
        [HttpGet("{id}")]
        public async Task<HomeStation> GetHomeStation([FromQuery] int id)
        {
            return await manager.GetHomeStation(id);
        }*/
        #endregion

        #region RegisterData
        [Route("RD")]
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

        [Route("RD")]
        [HttpPut]
        public async Task<ActionResult> UpdateRegisterData(RegisterData registerData)
        {
            return await manager.UpdateRegisterData(registerData) ? NoContent() : NotFound();
        }

        [Route("RD/{id}")]
        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteRegisterData(int id)
        {
            return await manager.RemoveRegisterData(id) ? NoContent() : NotFound();
        }

        /*
        [Route("RD/{id}")]
        [HttpGet("{id}")]
        public async Task<UserDTO> GetRegisterData(int id)
        {
            return await manager.GetRegisterData(id);          
        }
        */
        #endregion
    }
}
