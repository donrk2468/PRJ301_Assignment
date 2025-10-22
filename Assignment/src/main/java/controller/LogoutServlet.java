package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

// File: com.prj103.flashcard.controller.LogoutServlet.java

@WebServlet(name = "logout", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Hủy bỏ Session
        }
        
        // Xóa cookie userId (Giữ nguyên)
        Cookie cookie = new Cookie("userId", "");
        cookie.setMaxAge(0);
        cookie.setPath(request.getContextPath() + "/"); 
        response.addCookie(cookie);

        response.sendRedirect(request.getContextPath() + "/index.jsp"); 
    }
}