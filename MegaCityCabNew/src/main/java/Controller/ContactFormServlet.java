package Controller;

import DAO.MessageDAO;
import Model.Message;
import Utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/ContactFormServlet")
public class ContactFormServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String messageContent = request.getParameter("message");

       
        if (name == null || email == null || subject == null || messageContent == null || name.isEmpty() || email.isEmpty() || subject.isEmpty() || messageContent.isEmpty()) {
            response.sendRedirect("contact.jsp?error=All fields are required.");
            return;
        }

      
        Message message = new Message();
        message.setName(name);
        message.setEmail(email);
        message.setSubject(subject);
        message.setMessage(messageContent);

        try (Connection conn = DBConnection.getConnection()) {
            MessageDAO messageDAO = new MessageDAO(conn);

           
            if (messageDAO.saveMessage(message)) {
                response.sendRedirect("Home.jsp?message=Your message has been sent successfully.");
            } else {
                response.sendRedirect("Home.jsp?error=Failed to send the message.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Home.jsp?error=Database error.");
        }
    }
}
