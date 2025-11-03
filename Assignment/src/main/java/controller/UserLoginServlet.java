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
        
        request.setCharacterEncoding("UTF-8");
        UserDAO usDAO = new UserDAO();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String errorMessage = null;

        try {
            // DAO sử dụng BCrypt để xác thực an toàn
            int userId = usDAO.userLogin(email, password); 
            
            if (userId != 0) {
                // Đăng nhập thành công
                User user = usDAO.getUserById(userId); 
                
                // Lưu userId và username vào session
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("username", user.getName());
                
                // Tạo cookie lưu userId
                Cookie cookieUser = new Cookie("userId", String.valueOf(userId));
                cookieUser.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
                cookieUser.setPath(request.getContextPath());
                response.addCookie(cookieUser);
                
                // Chuyển hướng đến trang chủ servlet
                response.sendRedirect(request.getContextPath() + "/homePage");
                return;
            } else {
                // Sai email hoặc mật khẩu
                errorMessage = "Sai email hoặc mật khẩu.";
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(UserLoginServlet.class.getName()).log(Level.SEVERE, "Database error during login", ex);
            // Xử lý lỗi DB: Forward về trang login với thông báo lỗi
            errorMessage = "Lỗi hệ thống cơ sở dữ liệu. Vui lòng thử lại sau.";
        }
        
        // Xử lý lỗi: Forward về trang đăng nhập với thông báo
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            // Giữ lại email đã nhập
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("jsp/login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String registrationStatus = request.getParameter("registration");
        
        // Yêu cầu đã được thực hiện: Nếu đăng ký thành công, chuyển hướng về trang index.jsp
        if ("success".equals(registrationStatus)) {
            // Lưu thông báo thành công vào session để index.jsp có thể hiển thị.
            // Điều này cần thiết vì chúng ta sử dụng sendRedirect, làm mất Request Scope.
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
            
            // Chuyển hướng (Redirect) về index.jsp
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        // Mặc định: Hiển thị trang đăng nhập
        request.getRequestDispatcher("jsp/login.jsp").forward(request, response);
    }
}
