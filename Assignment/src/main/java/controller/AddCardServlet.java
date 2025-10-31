package controller;

import dal.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.SQLException;
import model.Card;

// AddCardServlet.java
@WebServlet(urlPatterns = {"/addCard"})
public class AddCardServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int deckId = Integer.parseInt(request.getParameter("deckId"));
        String front = request.getParameter("front");
        String back = request.getParameter("back");
        String example = request.getParameter("example");
        CardDAO dao = new CardDAO();
        dao.insertCard(new Card(deckId, front, back, example));
        response.sendRedirect("manageDeck?id=" + deckId);
    }
}
