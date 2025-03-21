package Model;

import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private int carId;
    private String carModel;
    private int customerId;
    private String pickupTime;
    private double totalBill;
    private Timestamp bookingDate;

   
    public Booking(int carId, String carModel, int customerId, String pickupTime, double totalBill) {
        this.carId = carId;
        this.carModel = carModel;
        this.customerId = customerId;
        this.pickupTime = pickupTime;
        this.totalBill = totalBill;
    }

   
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getCarId() { return carId; }
    public void setCarId(int carId) { this.carId = carId; }

    public String getCarModel() { return carModel; }
    public void setCarModel(String carModel) { this.carModel = carModel; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getPickupTime() { return pickupTime; }
    public void setPickupTime(String pickupTime) { this.pickupTime = pickupTime; }

    public double getTotalBill() { return totalBill; }
    public void setTotalBill(double totalBill) { this.totalBill = totalBill; }

    public Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(Timestamp bookingDate) { this.bookingDate = bookingDate; }
}
