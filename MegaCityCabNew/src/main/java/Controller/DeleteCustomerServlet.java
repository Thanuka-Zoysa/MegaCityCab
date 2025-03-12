package Controller;

import DAO.CustomerDAO;
import Utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));

        try (Connection conn = DBConnection.getConnection()) {
            CustomerDAO customerDAO = new CustomerDAO(conn);
            boolean success = customerDAO.deleteCustomer(customerId);

            if (success) {
                response.sendRedirect("admin_manageCustomers.jsp?message=Customer deleted successfully");
            } else {
                response.sendRedirect("admin_manageCustomers.jsp?error=Failed to delete customer");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_manageCustomers.jsp?error=Database error");
        }
    }
}
