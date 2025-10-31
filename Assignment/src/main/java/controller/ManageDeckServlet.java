package controller;

import dal.DeckDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.SQLException;
import java.util.*;
import model.Card;

// ManageDeckServlet.java
@WebServlet(urlPatterns = {"/manageDeck"})
public class ManageDeckServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int deckId = Integer.parseInt(request.getParameter("id"));
        DeckDAO dao = new DeckDAO();
        try {
            List<Card> cardList = dao.getCardsByDeckId(deckId);
            request.setAttribute("cardList", cardList);
            request.setAttribute("deckId", deckId);
            request.getRequestDispatcher("jsp/manage_deck.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
