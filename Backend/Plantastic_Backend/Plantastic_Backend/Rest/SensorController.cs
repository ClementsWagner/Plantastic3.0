using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.Rest
{
    [Route("backend/Sensor")]
    [ApiController]
    public class SensorController : ControllerBase
    {
        private readonly SensorManager manager;

        public SensorController(SensorManager manager)
        {
            this.manager = manager;
        }

        [HttpPost]
        public async Task<ActionResult> AddSensor(Sensor sensor)
        {
            try
            {
                await manager.AddSensor(new Sensor()
                {
                    DisplayName = sensor.DisplayName,
                    Mac = sensor.Mac,
                    PlantType = sensor.PlantType,
                    HomeStation = manager.GetHomeStation(sensor.HomeStation.Id).Result
                });
                return Created(string.Empty, sensor);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new ProblemDetails
                {
                    //Type = "https://",
                    Title = "Invalid sensor",
                    Detail = ex.Message,
                });
            }
        }

        [HttpPut]
        public async Task<ActionResult> UpdateSensor(Sensor sensor)
        {
            return await manager.UpdateSensor(sensor) ? NoContent() : NotFound();
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteSensor(int id)
        {
            return await manager.RemoveSensor(id) ? NoContent() : NotFound();
        }

        [HttpGet("{id}")]
        public async Task<SensorDTO> GetSensor(int id)
        {
            return await manager.GetSensor(id);
        }
    }
}
