package Model;

public class Car {
    private int carId;
    private String carModel;
    private String driverName;
    private String driverPhone;
    private String carPhoto;
    private boolean isAvailable;
    private double feePerKm;  // New field to store fee per km

    // Constructors
    public Car(String carModel, String driverName, String driverPhone, String carPhoto, boolean isAvailable, double feePerKm) {
        this.carModel = carModel;
        this.driverName = driverName;
        this.driverPhone = driverPhone;
        this.carPhoto = carPhoto;
        this.isAvailable = isAvailable;
        this.feePerKm = feePerKm;  // Set fee per km
    }

    // Getters and Setters
    public int getCarId() { return carId; }
    public void setCarId(int carId) { this.carId = carId; }

    public String getCarModel() { return carModel; }
    public void setCarModel(String carModel) { this.carModel = carModel; }

    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }

    public String getDriverPhone() { return driverPhone; }
    public void setDriverPhone(String driverPhone) { this.driverPhone = driverPhone; }

    public String getCarPhoto() { return carPhoto; }
    public void setCarPhoto(String carPhoto) { this.carPhoto = carPhoto; }

    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean isAvailable) { this.isAvailable = isAvailable; }

    public double getFeePerKm() { return feePerKm; }  // Getter for fee per km
    public void setFeePerKm(double feePerKm) { this.feePerKm = feePerKm; }  // Setter for fee per km
}
