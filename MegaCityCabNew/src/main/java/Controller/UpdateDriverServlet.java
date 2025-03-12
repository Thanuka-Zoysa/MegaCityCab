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

@WebServlet("/UpdateDriverServlet")
public class UpdateDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        int carId = Integer.parseInt(request.getParameter("carId"));
        String fullName = request.getParameter("fullName");
        String nic = request.getParameter("nic");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String photo = request.getParameter("photo");

        Driver driver = new Driver(carId, fullName, nic, phone, address, photo);
        driver.setDriverId(driverId);

        try (Connection conn = DBConnection.getConnection()) {
            DriverDAO driverDAO = new DriverDAO(conn);

            if (driverDAO.updateDriver(driver)) {
                response.sendRedirect("admin_manageDrivers.jsp?message=Driver updated successfully");
            } else {
                response.sendRedirect("admin_manageDrivers.jsp?error=Failed to update driver");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_manageDrivers.jsp?error=Database error");
        }
    }
}
