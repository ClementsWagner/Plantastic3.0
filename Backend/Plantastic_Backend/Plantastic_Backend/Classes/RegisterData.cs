using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.Classes
{
    public class RegisterData
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int HomeStationId { get; set; }
        public bool Notification { get; set; }
    }
}
