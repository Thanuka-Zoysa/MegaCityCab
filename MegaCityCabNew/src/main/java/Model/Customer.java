package Model;

public class Customer {
    private int customerId;
    private String name;
    private String email;
    private String address;
    private String phone;
    private String nic;
    private String password;
    private boolean isAdmin; // New field to mark the admin

    // Constructors
    public Customer() {}

    public Customer(String name, String email, String address, String phone, String nic, String password) {
        this.name = name;
        this.email = email;
        this.address = address;
        this.phone = phone;
        this.nic = nic;
        this.password = password;
    }

    // Getters and Setters
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    // Getter and Setter for isAdmin
    public boolean isAdmin() { return isAdmin; }
    public void setAdmin(boolean isAdmin) { this.isAdmin = isAdmin; }
}
