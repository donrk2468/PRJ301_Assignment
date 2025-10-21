package controller;

import model.Card;
import dal.DeckDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "deck", urlPatterns = {"/deck"})
public class DeckServlet extends HttpServlet {

    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        int deckId = Integer.parseInt(request.getParameter("id"));
//        request.setAttribute("deckId", deckId);
//        request.getRequestDispatcher("jsp/home.jsp").forward(request, response);
//    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String deckIdParam = request.getParameter("id");

        // Kiểm tra nếu không có tham số deckId
        if (deckIdParam == null || deckIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số deckId trong yêu cầu.");
            return;
        }

        try {
            int deckId = Integer.parseInt(deckIdParam);
            DeckDAO deckDAO = new DeckDAO();
            List<Card> cards = deckDAO.getCardsByDeckId(deckId);

            // Gửi dữ liệu sang JSP
            request.setAttribute("cards", cards);
            request.setAttribute("deckId", deckId);
            request.getRequestDispatcher("jsp/card.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tham số deckId không hợp lệ.");
        } catch (SQLException e) {
            Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi truy vấn dữ liệu.");
        }
    }
}
