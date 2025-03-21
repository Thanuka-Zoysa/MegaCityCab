package Controller;

import DAO.MessageDAO;
import Utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/DeleteMessageServlet")
public class DeleteMessageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String messageIdStr = request.getParameter("messageId");

       t
        if (messageIdStr == null || messageIdStr.isEmpty()) {
            response.sendRedirect("admin_viewMessage.jsp?error=Invalid message ID.");
            return;
        }

        try {
            int messageId = Integer.parseInt(messageIdStr);

         
            try (Connection conn = DBConnection.getConnection()) {
                MessageDAO messageDAO = new MessageDAO(conn);

             
                boolean isDeleted = messageDAO.deleteMessage(messageId);
                if (isDeleted) {
                    response.sendRedirect("admin_viewMessage.jsp?message=Message deleted successfully.");
                } else {
                    response.sendRedirect("admin_viewMessage.jsp?error=Failed to delete the message.");
                }
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("admin_viewMessage.jsp?error=Invalid message ID format.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_viewMessage.jsp?error=Database error.");
        }
    }
}
