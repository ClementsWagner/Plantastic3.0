namespace PlanTastic_Backend.Classes
{
    public record UserDTO(int Id, string Email);
    public class User
    {
        public int Id { get; set; }
        public String Email { get; set; }
        public String Password { get; set; }
    }
}
