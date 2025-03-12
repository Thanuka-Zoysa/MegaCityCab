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

@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");

        try (Connection conn = DBConnection.getConnection()) {
            CustomerDAO customerDAO = new CustomerDAO(conn);

            boolean success = customerDAO.updateCustomerDetails(customerId, name, email, phone, address, nic);

            if (success) {
                response.sendRedirect("admin_manageCustomers.jsp?message=Customer updated successfully");
            } else {
                response.sendRedirect("admin_manageCustomers.jsp?error=Failed to update customer");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_manageCustomers.jsp?error=Database error");
        }
    }
}
