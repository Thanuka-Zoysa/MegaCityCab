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
import java.util.List;

@WebServlet("/AdminCustomersServlet")
public class AdminCustomersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

     
        if (isAdmin == null || !isAdmin) {
            response.sendRedirect("login.jsp?error=Access Denied");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            CustomerDAO customerDAO = new CustomerDAO(conn);
            List<Customer> customers = customerDAO.getAllCustomers();

            request.setAttribute("customers", customers);
            request.getRequestDispatcher("admin_manageCustomers.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?error=Database Error");
        }
    }
}
