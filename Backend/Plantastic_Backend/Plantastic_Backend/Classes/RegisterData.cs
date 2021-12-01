using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanTastic_Backend.Classes
{
    public class RegisterData
    {
        private int Id { get; set; }
        private int UserId { get; set; }
        private int HomeStationId { get; set; }
        private bool Notification { get; set; }
    }
}
