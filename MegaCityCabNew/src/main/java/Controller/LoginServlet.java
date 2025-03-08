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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check if email or password is empty
        if (email.isEmpty() || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=All fields are required");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            CustomerDAO customerDAO = new CustomerDAO(conn);
            Customer customer = customerDAO.authenticateCustomer(email, password);

            if (customer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("customerId", customer.getCustomerId());
                session.setAttribute("customer", customer);  // Store the customer object in the session

                // Check if the customer is an admin
                if (customer.isAdmin()) {
                    // Store admin's details in the session
                    session.setAttribute("isAdmin", true);
                    // Redirect to Admin Dashboard if the user is an admin
                    response.sendRedirect("admin_dashboard.jsp");
                } else {
                    // Redirect to Customer Dashboard if the user is a regular customer
                    response.sendRedirect("dashboard.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid email or password");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database connection error");
        }
    }
}

