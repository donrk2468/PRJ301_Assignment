package com.prj103.flashcard.controller;

import com.prj103.flashcard.model.*;
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
        
        CategoryDAO dao = new CategoryDAO();
        List<Category> list = dao.getAllCategories();
        
        request.setAttribute("category", list);
        request.getRequestDispatcher("jsp/category.jsp").forward(request, response);
    }
}
