package controller;

import model.Card; // Cần dùng model.Card
import dal.DeckDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(name = "deck", urlPatterns = {"/deck"})
public class DeckServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // 1. LẤY deckId TỪ REQUEST HOẶC SESSION (Giữ nguyên)
        String deckIdParam = request.getParameter("id");
        Integer deckId = (Integer) session.getAttribute("currentDeckId");
        String categoryId = request.getParameter("categoryId");
        
        if (deckIdParam != null && !deckIdParam.isEmpty()) {
            try {
                int newDeckId = Integer.parseInt(deckIdParam);
                if (deckId == null || newDeckId != deckId) {
                    deckId = newDeckId;
                    session.setAttribute("currentDeckId", deckId);
                    session.setAttribute("cardIndex", 0); // Reset index khi chọn deck mới
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tham số deckId không hợp lệ.");
                return;
            }
        }
        
        if (deckId == null) {
            response.sendRedirect("homePage"); // Chuyển về trang chủ nếu không có deckId
            return;
        }

        // 2. TẢI DANH SÁCH THẺ TỪ DB (Giữ nguyên)
        List<Card> cards;
        try {
            DeckDAO deckDAO = new DeckDAO();
            cards = deckDAO.getCardsByDeckId(deckId);
        } catch (SQLException e) {
            Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, "Lỗi truy vấn thẻ.", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi truy vấn dữ liệu thẻ.");
            return;
        }

        if (cards.isEmpty()) {
            // Nếu không có thẻ nào, gửi thông báo và các thông tin cần thiết
            request.setAttribute("message", "Bộ thẻ này hiện chưa có thẻ nào. Hãy thêm thẻ mới!");
            request.setAttribute("deckId", deckId);
            request.setAttribute("currentCardNumber", 0);
            request.setAttribute("totalCards", 0);
        } else {
            // Nếu có thẻ, tiếp tục xử lý logic như cũ
            Integer cardIndex = (Integer) session.getAttribute("cardIndex");
            if (cardIndex == null || cardIndex >= cards.size()) { // Kiểm tra index hợp lệ
                cardIndex = 0;
            }
            
            String action = request.getParameter("action");
            if ("next".equals(action)) {
                cardIndex = (cardIndex + 1) % cards.size();
            } else if ("prev".equals(action)) {
                cardIndex = (cardIndex - 1 + cards.size()) % cards.size();
            }

            session.setAttribute("cardIndex", cardIndex);
            
            request.setAttribute("card", cards.get(cardIndex));
            request.setAttribute("deckId", deckId);
            request.setAttribute("currentCardNumber", cardIndex + 1);
            request.setAttribute("totalCards", cards.size());
        }
        request.setAttribute("categoryId", categoryId);
        
        // 5. CHUYỂN TIẾP ĐẾN JSP
        request.getRequestDispatcher("/jsp/card.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}