package Controller;

import DAO.CarDAO;
import Utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/DeleteCarServlet")
public class DeleteCarServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("carId"));

        try (Connection conn = DBConnection.getConnection()) {
            CarDAO carDAO = new CarDAO(conn);
            if (carDAO.deleteCar(carId)) {
                response.sendRedirect("admin_manageRentCars.jsp?message=Car deleted successfully");
            } else {
                response.sendRedirect("admin_manageRentCars.jsp?error=Failed to delete car");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_manageRentCars.jsp?error=Database error");
        }
    }
}
