package Controller;

import DAO.DriverDAO;
import Model.Driver;
import Utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/addDriver")
public class AdminDriverController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carId = request.getParameter("carId");
        String fullName = request.getParameter("fullName");
        String nic = request.getParameter("nic");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String photo = request.getParameter("photo"); 


        if (carId.isEmpty() || fullName.isEmpty() || nic.isEmpty() || phone.isEmpty() || address.isEmpty() || photo.isEmpty()) {
            response.sendRedirect("admin_dashboard.jsp?error=All fields are required");
            return;
        }


        Driver driver = new Driver(Integer.parseInt(carId), fullName, nic, phone, address, photo);

        try (Connection conn = DBConnection.getConnection()) {
            DriverDAO driverDAO = new DriverDAO(conn);
            if (driverDAO.addDriver(driver)) {
                response.sendRedirect("admin_manageDrivers.jsp?message=Driver added successfully");
            } else {
                response.sendRedirect("admin_manageDrivers.jsp?error=Failed to add driver");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_manageDrivers.jsp?error=Database error");
        }
    }
}
