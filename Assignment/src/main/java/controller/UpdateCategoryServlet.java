package controller;

import dal.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/updateCategory"})
public class UpdateCategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String categoryName = request.getParameter("categoryName");
        CategoryDAO dao = new CategoryDAO();
        try { dao.updateCategory(categoryId, categoryName); } catch (SQLException e) { throw new ServletException(e); }
        response.sendRedirect("CategoryDirect");
    }
}