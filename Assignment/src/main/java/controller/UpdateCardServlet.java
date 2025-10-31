package controller;

import dal.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.SQLException;
import model.Card;

// UpdateCardServlet.java
@WebServlet(urlPatterns = {"/updateCard"})
public class UpdateCardServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int cardId = Integer.parseInt(request.getParameter("cardId"));
        int deckId = Integer.parseInt(request.getParameter("deckId"));
        String front = request.getParameter("front");
        String back = request.getParameter("back");
        String example = request.getParameter("example");
        String source = request.getParameter("source");
        CardDAO dao = new CardDAO();
        dao.updateCard(new Card(cardId, deckId, front, back, example));
        if ("manage".equals(source)) {
            response.sendRedirect("manageDeck?id=" + deckId);
        } else {
            response.sendRedirect("deck?id=" + deckId);
        }
    }
}
