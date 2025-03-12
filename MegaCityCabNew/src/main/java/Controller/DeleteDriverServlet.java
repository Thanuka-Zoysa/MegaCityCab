package Controller;

import DAO.DriverDAO;
import Utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/DeleteDriverServlet")
public class DeleteDriverServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int driverId = Integer.parseInt(request.getParameter("driverId"));

        try (Connection conn = DBConnection.getConnection()) {
            DriverDAO driverDAO = new DriverDAO(conn);
            boolean success = driverDAO.deleteDriver(driverId);

            if (success) {
                response.sendRedirect("admin_manageDrivers.jsp?message=Driver deleted successfully");
            } else {
                response.sendRedirect("admin_manageDrivers.jsp?error=Failed to delete driver");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_manageDrivers.jsp?error=Database error");
        }
    }
}
