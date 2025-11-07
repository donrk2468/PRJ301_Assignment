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

@WebServlet(urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String errorMessage = null;
        UserDAO dao = new UserDAO();
        try {
            boolean success = dao.register(email, password, name);
            if (success) {
                request.setAttribute("email",email);
                request.setAttribute("password",password);
                request.getRequestDispatcher("login2").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Entered email has been registered!");
                request.getRequestDispatcher("jsp/register.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
