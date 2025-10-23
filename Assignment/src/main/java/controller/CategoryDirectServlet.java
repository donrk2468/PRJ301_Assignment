package controller;

import dal.*;
import model.Category;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryDirect", urlPatterns = {"/CategoryDirect"})
public class CategoryDirectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        int userId = (Integer) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");

        // a. Lấy dữ liệu (Category list theo userId)
        CategoryDAO dao = new CategoryDAO();
        List<Category> list = dao.getCategoriesbyUserId(userId);

        // b. Truyền dữ liệu sang JSP
        request.setAttribute("categoryList", list);
        request.setAttribute("username", username);

        // c. Forward request đến trang hiển thị danh sách category
        request.getRequestDispatcher("jsp/category.jsp").forward(request, response);

    }
}
