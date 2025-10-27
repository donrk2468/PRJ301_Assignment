package controller;

import dal.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "login2", urlPatterns = {"/login2"})
public class UserLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserDAO usDAO = new UserDAO();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        try {
            int userId = usDAO.userLogin(email, password);
            if (userId != 0) {
                // Lấy thông tin người dùng, ví dụ tên từ database (UserDAO có thể có phương thức lấy user)
                User user = usDAO.getUserById(userId); // giả sử có method này
                
                // Lưu userId và username vào session
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("username", user.getName());

                // Tạo cookie lưu userId để nhớ đăng nhập trong 7 ngày
                Cookie cookieUser = new Cookie("userId", String.valueOf(userId));
                cookieUser.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
                cookieUser.setPath(request.getContextPath());
                response.addCookie(cookieUser);

                // Chuyển hướng đến trang chủ servlet
                response.sendRedirect(request.getContextPath() + "/homePage");
                return;
            } else {
                request.setAttribute("errorMessage", "Sai email hoặc mật khẩu.");
                request.getRequestDispatcher("jsp/login.jsp").forward(request, response);
                
                return;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi máy chủ.");
        }
    }
}