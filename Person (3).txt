package Portal;

public abstract class Person {
    private String firstName;
    private String lastName;
    private String email;
    private String contact;
    private String address;

    public Person(String firstName, String lastName, String email,
    String contact, String address) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.contact = contact;
        this.address = address;
    }

    public String getFirstName() { return firstName; }
    public String getLastName() { return lastName; }
    public String getFullName() { return firstName + " " + lastName; }
    public String getEmail() { return email; }
    public String getContact() { return contact; }
    public String getAddress() { return address; }

    public void setFirstName(String firstName) { this.firstName = firstName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public void setEmail(String email) { this.email = email; }
    public void setContact(String contact) { this.contact = contact; }
    public void setAddress(String address) { this.address = address; }

    public abstract String getPersonType();
}