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
        Blume
    }

    public record SensorDTO(int Id, string name, PlantTypes plantType, int Status, double Power, DateTime Time);

    public class Sensor
    {

        public int Id { get; set; }
        public HomeStation HomeStation { get; set; }
        public String Mac { get; set; }
        public String DisplayName { get; set; }
        public PlantTypes PlantType { get; set; }
    }
    public class SensorData
    {
        public int Id { get; set; }
        public Sensor Sensor { get; set; }
        public double Power { get; set; }
        public int Moisture { get; set; }
        public double Light { get; set; }
        public DateTime Time { get; set; }

        public static int Status(SensorData data)
        {
            return (int)(data.Moisture + data.Light) / 2;
        }
    }

    public record SensorDataDTO(String mac, double Power, int Moisture, double Light);
}
