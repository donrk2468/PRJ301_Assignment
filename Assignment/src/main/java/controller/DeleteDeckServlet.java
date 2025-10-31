package controller;

import dal.DeckDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.SQLException;


// DeleteDeckServlet.java
@WebServlet(urlPatterns = {"/deleteDeck"})
public class DeleteDeckServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int deckId = Integer.parseInt(request.getParameter("id"));
        DeckDAO dao = new DeckDAO();
        try { dao.deleteDeck(deckId); } catch (SQLException e) { throw new ServletException(e); }
        response.sendRedirect("category?id=" + categoryId);
    }
}