package Controller;

import DAO.CustomerDAO;
import Model.Customer;
import Utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String nic = request.getParameter("nic");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=Passwords do not match");
            return;
        }

        // Determine if this is an admin registration
        boolean isAdmin = request.getParameter("isAdmin") != null;

        // Create customer object
        Customer customer = new Customer(name, email, address, phone, nic, password);
        customer.setAdmin(isAdmin);  // Set the admin flag

        try (Connection conn = DBConnection.getConnection()) {
            CustomerDAO customerDAO = new CustomerDAO(conn);  // Pass the Connection object
            if (customerDAO.registerCustomer(customer)) {
                if (isAdmin) {
                    response.sendRedirect("admin_dashboard.jsp?message=Admin registration successful");
                } else {
                    response.sendRedirect("login.jsp?message=Registration successful");
                }
            } else {
                response.sendRedirect("register.jsp?error=Email or NIC already exists");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Database error");
        }
    }
}
