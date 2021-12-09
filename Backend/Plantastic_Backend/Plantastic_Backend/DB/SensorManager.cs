using Plantastic_Backend.DB;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.DB
{
    internal class SensorManager
    {
        private readonly PlantasticContext context;

        public SensorManager(PlantasticContext context)
        {
            this.context = context;
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
            return await context.Sensors.Where(h => h.Id == id)
                .Join(context.SensorDatas, sen => sen.Id, senD => senD.Sensor.Id,(sen, senD) => senD)
                .Select(s => new SensorDTO(s.Sensor.Id, s.Sensor.DisplayName, s.Sensor.PlantType, 
                SensorData.Status(s), s.Power))
                .FirstOrDefaultAsync();
        }
#endregion

        #region SensorData
        public async Task AddSensorData(SensorData sensorData)
        {
            sensorData.Time = DateTime.Now;
            context.SensorDatas.Add(sensorData);
            await context.SaveChangesAsync();
        }
#endregion
    }
}
