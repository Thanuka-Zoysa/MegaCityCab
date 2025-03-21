package Controller;

import DAO.CarDAO;
import Model.Car;
import Utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/addCar")
public class AdminCarController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carModel = request.getParameter("carModel");
        String driverName = request.getParameter("driverName");
        String driverPhone = request.getParameter("driverPhone");
        String carPhoto = request.getParameter("carPhoto"); 
        boolean isAvailable = request.getParameter("isAvailable") != null;
        double feePerKm = Double.parseDouble(request.getParameter("feePerKm"));

 
        if (carModel.isEmpty() || driverName.isEmpty() || driverPhone.isEmpty() || carPhoto.isEmpty()) {
            response.sendRedirect("admin_dashboard.jsp?error=All fields are required");
            return;
        }


        Car car = new Car(carModel, driverName, driverPhone, carPhoto, isAvailable, feePerKm); 

        try (Connection conn = DBConnection.getConnection()) {
            CarDAO carDAO = new CarDAO(conn);
            if (carDAO.addCar(car)) {
                response.sendRedirect("admin_manageRentCars.jsp?message=Car added successfully");
            } else {
                response.sendRedirect("admin_manageRentCars.jsp?error=Failed to add car");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_manageRentCars.jsp?error=Database error");
        }
    }
}
