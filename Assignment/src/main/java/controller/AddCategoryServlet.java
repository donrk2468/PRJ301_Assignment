/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {"/addCategory"})
public class AddCategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String categoryName = request.getParameter("categoryName");
        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("userId");
        CategoryDAO dao = new CategoryDAO();
        try { dao.addCategory(userId, categoryName); } catch (SQLException e) { throw new ServletException(e); }
        response.sendRedirect("CategoryDirect");
    }
}
