package Controller;

import DAO.CustomerDAO;
import Model.Customer;
import Utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/EditAdminProfileServlet")
public class EditAdminProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            CustomerDAO customerDAO = new CustomerDAO(conn);
            boolean success = customerDAO.updateCustomerProfile(customerId, name, email, phone, address, password);

            if (success) {
              
                HttpSession session = request.getSession();
                session.setAttribute("customer", customerDAO.getCustomerById(customerId));
                
                response.sendRedirect("admin_profile.jsp?message=Profile updated successfully");
            } else {
                response.sendRedirect("admin_profile.jsp?error=Failed to update profile");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_profile.jsp?error=Database error");
        }
    }
}
