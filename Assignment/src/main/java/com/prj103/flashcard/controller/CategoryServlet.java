package com.prj103.flashcard.controller;

import com.prj103.flashcard.model.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import com.prj103.flashcard.dal.*;

@WebServlet(name = "category", urlPatterns = {"/category"})
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("id"));
        DeckDAO dao = new DeckDAO();
        List<Deck> list = dao.getDecksByCategory(categoryId);

        request.setAttribute("deck", list);
        request.getRequestDispatcher("jsp/deck.jsp").forward(request, response);
    }
}
