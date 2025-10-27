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

        // 1. KIỂM TRA SESSION VÀ COOKIE ĐỂ XÁC ĐỊNH TRẠNG THÁI ĐĂNG NHẬP
        if (session != null) {
            userId = (Integer) session.getAttribute("userId");
            username = (String) session.getAttribute("username");
        }

        // Nếu session không có, thử lấy từ cookie (logic "ghi nhớ đăng nhập")
        if (userId == null) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("userId".equals(c.getName()) && !c.getValue().isEmpty()) {
                        try {
                            userId = Integer.parseInt(c.getValue());
                            if (userId != null) {
                                // Lấy thông tin user từ DB
                                dal.UserDAO userDAO = new dal.UserDAO();
                                model.User user = userDAO.getUserById(userId);
                                username = user.getName();
                                
                                // Tạo session mới và lưu lại
                                session = request.getSession(true);
                                session.setAttribute("userId", userId);
                                session.setAttribute("username", username);
                            }
                        } catch (Exception e) {
                            userId = null; // Bỏ qua nếu có lỗi (ví dụ: cookie hỏng, user không tồn tại)
                        }
                        break;
                    }
                }
            }
        }

        // 2. XỬ LÝ CHUYỂN HƯỚNG DỰA TRÊN TRẠNG THÁI ĐĂNG NHẬP
        
        if (userId == null) {
            // TRƯỜNG HỢP 1: CHƯA ĐĂNG NHẬP
            // Chuyển về trang login
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return; // Quan trọng: Dừng xử lý Servlet
        } else {
            // TRƯỜNG HỢP 2: ĐÃ ĐĂNG NHẬP
            
            // a. Lấy dữ liệu (Category list theo userId)
            CategoryDAO dao = new CategoryDAO();
            List<Category> list = dao.getCategoriesbyUserId(userId);
            
            // b. Truyền dữ liệu sang JSP
            request.setAttribute("categoryList", list); // Đặt tên là "categoryList" để dễ phân biệt
//            request.setAttribute("username", username);
            
            // c. Forward request đến trang hiển thị danh sách category
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}