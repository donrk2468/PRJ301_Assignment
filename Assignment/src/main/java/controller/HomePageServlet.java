package controller;

import dal.*;
import model.Category;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "homePage", urlPatterns = {"/homePage"})
public class HomePageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Integer userId = null;
        String username = null;

        if (session != null) {
            userId = (Integer) session.getAttribute("userId");
            username = (String) session.getAttribute("username");
        }

        // Nếu session không có, thử lấy từ cookie
        if (userId == null) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("userId".equals(c.getName())) {
                        try {
                            userId = Integer.parseInt(c.getValue());
                        } catch (NumberFormatException e) {
                            userId = null;
                        }
                        break;
                    }
                }
            }
            // Nếu lấy userId từ cookie được, bạn có thể lấy tên user ở đây bằng DB
            if (userId != null) {
                // Giả sử có thể lấy user tên như sau:
                try {
                    dal.UserDAO userDAO = new dal.UserDAO();
                    model.User user = userDAO.getUserById(userId);
                    username = user.getName();
                    // Lưu lại session để lần sau khỏi đọc cookie
                    session = request.getSession(true);
                    session.setAttribute("userId", userId);
                    session.setAttribute("username", username);
                } catch (Exception e) {
                    userId = null;
                    username = null;
                }
            }
        }

        if (userId == null) {
            // Chưa đăng nhập -> chuyển về trang login
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        CategoryDAO dao = new CategoryDAO();
        List<Category> list = dao.getCategoriesbyUserId(userId);
        
        request.setAttribute("category", list);
        request.setAttribute("username", username);
        request.getRequestDispatcher("jsp/index.jsp").forward(request, response);
    }
}