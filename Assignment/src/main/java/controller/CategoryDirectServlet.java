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
        
        // 1. Lấy session, sử dụng getSession(false) là đúng để kiểm tra session hiện tại
        HttpSession session = request.getSession(false);
        String categoryId = (String) request.getAttribute("categoryId");
        
        // 2. Kiểm tra NULL SESSION trước tiên
        if (session == null || session.getAttribute("userId") == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }
        int userId = (Integer) session.getAttribute("userId");
        String username = (String) session.getAttribute("username"); 
        CategoryDAO dao = new CategoryDAO();
        List<Category> list = dao.getCategoriesbyUserId(userId);
        request.setAttribute("categoryList", list);
        request.setAttribute("categoryId", categoryId);
        request.getRequestDispatcher("jsp/category.jsp").forward(request, response);
    }
}