package Model;

public class Driver {
    private int driverId;
    private int carId; 
    private String fullName;
    private String nic;
    private String phone;
    private String address;
    private String photo;

  
    public Driver(int carId, String fullName, String nic, String phone, String address, String photo) {
        this.carId = carId;
        this.fullName = fullName;
        this.nic = nic;
        this.phone = phone;
        this.address = address;
        this.photo = photo;
    }

   
    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }
}
