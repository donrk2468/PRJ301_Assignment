package controller;

import dal.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.SQLException;
import model.Card;

// DeleteCardServlet.java
@WebServlet(urlPatterns = {"/deleteCard"})
public class DeleteCardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int cardId = Integer.parseInt(request.getParameter("id"));
        int deckId = Integer.parseInt(request.getParameter("deckId"));
        CardDAO dao = new CardDAO();
        dao.deleteCard(cardId);
        response.sendRedirect("manageDeck?id=" + deckId);
    }
}