using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.Classes
{
    enum PlantType
    {
        Kaktus,
        Gemüse,
        Obst,
        Blumen
    }
    internal class Sensor
    {

        private int Id { get; set; }
        private int HomeStationId { get; set; }
        private String Mac { get; set; }
        private String DisplayName { get; set; }
        private PlantType PlantType { get; set; }
    }
    internal class SensorData
    {
        private int Id { get; set; }
        private int SensorId { get; set; }
        private double Power { get; set; }
        private double Moisture { get; set; }
        private bool Available { get; set; }
        private double Light { get; set; }
    }
}
