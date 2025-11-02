package controller;

import dal.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Card;
import model.User;

// AddCardServlet.java
@WebServlet(urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        UserDAO dao = new UserDAO();
        try {
            User u = dao.register(email, password, name);
            if (u == null) {
                request.setAttribute("errorMessage", "Entered email has been registered!");
                request.getRequestDispatcher("jsp/register.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "");
                response.sendRedirect("login2");
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
