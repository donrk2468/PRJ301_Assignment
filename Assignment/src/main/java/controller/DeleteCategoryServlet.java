package controller;

import dal.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.SQLException;


// DeleteCategoryServlet.java
@WebServlet(urlPatterns = {"/deleteCategory"})
public class DeleteCategoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("id"));
        CategoryDAO dao = new CategoryDAO();
        try { dao.deleteCategory(categoryId); } catch (SQLException e) { throw new ServletException(e); }
        response.sendRedirect("CategoryDirect");
    }
}