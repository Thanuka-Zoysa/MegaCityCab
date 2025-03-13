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
                session.setAttribute("customer", customer);  

               
                if (customer.isAdmin()) {
                   
                    session.setAttribute("isAdmin", true);
                  
                    response.sendRedirect("admin_dashboard.jsp");
                } else {
                  
                    response.sendRedirect("dashboard.jsp?message=Logout successful!");
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

