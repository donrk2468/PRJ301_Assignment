package controller;

import dal.DeckDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.SQLException;

// AddDeckServlet.java
@WebServlet(urlPatterns = {"/addDeck"})
public class AddDeckServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String deckName = request.getParameter("deckName");
        DeckDAO dao = new DeckDAO();
        try { dao.addDeck(categoryId, deckName); } catch (SQLException e) { throw new ServletException(e); }
        response.sendRedirect("category?id=" + categoryId);
    }
}