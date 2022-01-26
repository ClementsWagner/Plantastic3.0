using Plantastic_Backend.DB;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.DB
{
    public class SensorManager
    {
        private readonly PlantasticContext context;

        public SensorManager(PlantasticContext context)
        {
            this.context = context;
        }

        public async Task<HomeStation> GetHomeStation(int id)
        {
            return await context.HomeStations.Where(h => h.Id == id).FirstOrDefaultAsync();
        }

        #region Sensor
        public async Task AddSensor(Sensor sensor)
        {
            context.Sensors.Add(sensor);
            await context.SaveChangesAsync();
        }

        public async Task<bool> RemoveSensor(int id)
        {
            var sensor = await context.Sensors.FirstOrDefaultAsync(s => s.Id == id);
            if (sensor == null)
                return false;

            context.Sensors.Remove(sensor);
            await context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> UpdateSensor(Sensor sensor)
        {
            if (sensor == null)
                return false;

            context.Sensors.Update(sensor);
            await context.SaveChangesAsync();
            return true;
        }

        public async Task<SensorDTO> GetSensor(int id)
        {
            return await context.SensorDatas.Where(h => h.Sensor.Id == id).OrderByDescending(t => t.Time)
                .Select(s => new SensorDTO(s.Sensor.Id, s.Sensor.DisplayName, s.Sensor.PlantType, 
                SensorData.Status(s), s.Power))
                .FirstAsync();
        }
#endregion

        #region SensorData
        public async Task AddSensorData(SensorDataDTO sensorData)
        {
            SensorData data = new SensorData()
            {
                Sensor = context.Sensors.Where(h => h.Mac == sensorData.mac).FirstOrDefault(),
                Light = sensorData.Light,
                Moisture = sensorData.Moisture,
                Power = sensorData.Power,
                Time = DateTime.Now
        };
            context.SensorDatas.Add(data);
            await context.SaveChangesAsync();
        }
#endregion
    }
}
