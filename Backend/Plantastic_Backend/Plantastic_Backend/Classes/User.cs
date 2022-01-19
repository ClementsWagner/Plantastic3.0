using ServiceStack.DataAnnotations;

namespace PlanTastic_Backend.Classes
{
    public record Passwort(String passwort);
    public record UserDTO(int id,string Email);
    public class User
    {
        public int Id { get; set; }
        [Unique]
        public String Email { get; set; }
        public String? Password { get; set; }
        public byte[]? Salt { get; set; }
    }
}
