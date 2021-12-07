using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.Classes
{
    public enum PlantTypes
    {
        Kaktus,
        Gemüse,
        Obst,
        Blumen
    }
    public class Sensor
    {

        public int Id { get; set; }
        public int HomeStationId { get; set; }
        public String Mac { get; set; }
        public String DisplayName { get; set; }
        public PlantTypes PlantType { get; set; }
    }
    public class SensorData
    {
        public int Id { get; set; }
        public int SensorId { get; set; }
        public double Power { get; set; }
        public double Moisture { get; set; }
        public bool Available { get; set; }
        public double Light { get; set; }
    }
}
