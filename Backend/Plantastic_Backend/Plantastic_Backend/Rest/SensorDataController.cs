namespace Plantastic_Backend.Rest
{
    [Route("backend/SensorData")]
    [ApiController]
    public class SensorDataController : ControllerBase
    {
        private readonly SensorManager manager;

        public SensorDataController(SensorManager manager)
        {
            this.manager = manager;
        }

        [HttpPost]
        public async Task<ActionResult> AddSensorData(SensorData sensorData)
        {
            try
            {
                await manager.AddSensorData(sensorData);
                return Created(string.Empty, sensorData);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new ProblemDetails
                {
                    //Type = "https://",
                    Title = "Invalid sensorData",
                    Detail = ex.Message,
                });
            }
        }
    }
}
