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
    }
    internal class SensorDataManager
    {
        private readonly PlantasticContext context;

        public SensorDataManager(PlantasticContext context)
        {
            this.context = context;
        }

        public async Task AddSensorData(SensorData sensorData)
        {
            context.SensorDatas.Add(sensorData);
            await context.SaveChangesAsync();
        }

        public async Task<bool> RemoveSensorData(int id)
        {
            var sensorData = await context.SensorDatas.FirstOrDefaultAsync(sd => sd.Id == id);
            if (sensorData == null)
                return false;

            context.SensorDatas.Remove(sensorData);
            await context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> UpdateSensorData(SensorData sensorData)
        {
            if (sensorData == null)
                return false;

            context.SensorDatas.Update(sensorData);
            await context.SaveChangesAsync();
            return true;
        }
    }
}
