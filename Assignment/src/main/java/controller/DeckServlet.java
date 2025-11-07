package controller;

import model.Card;
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

    private static final Logger LOGGER = Logger.getLogger(DeckServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // 1. LẤY ID TỪ REQUEST & SESSION

        String deckIdParam = request.getParameter("id");
        // currentDeckId được lưu là Integer
        Integer deckId = (Integer) session.getAttribute("currentDeckId");
        
        // categoryId cũng được lưu là Integer, cần chuyển sang String an toàn cho JSP
        Integer categoryIdObj = (Integer) session.getAttribute("categoryId");
        String categoryId = (categoryIdObj != null) ? String.valueOf(categoryIdObj) : null;
        
        
        // 2. XỬ LÝ deckId TỪ PARAMETER
        if (deckIdParam != null && !deckIdParam.isEmpty()) {
            try {
                int newDeckId = Integer.parseInt(deckIdParam);
                
                // Nếu là Deck mới, hoặc lần đầu truy cập, reset index thẻ
                if (deckId == null || newDeckId != deckId) {
                    deckId = newDeckId;
                    session.setAttribute("currentDeckId", deckId);
                    session.setAttribute("cardIndex", 0); 
                }
            } catch (NumberFormatException e) {
                // Nếu tham số deckId không phải số
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tham số deckId không hợp lệ.");
                return;
            }
        }

        // 3. KIỂM TRA TÍNH HỢP LỆ CỦA deckId
        if (deckId == null) {
            // Nếu không có deckId trong cả request lẫn session, chuyển về trang chủ
            response.sendRedirect(request.getContextPath() + "/homePage");
            return;
        }

        // 4. TẢI DANH SÁCH THẺ TỪ DB
        List<Card> cards;
        try {
            DeckDAO deckDAO = new DeckDAO();
            cards = deckDAO.getCardsByDeckId(deckId);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi truy vấn thẻ cho Deck ID: " + deckId, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi truy vấn dữ liệu thẻ.");
            return;
        }
        
        // 5. XỬ LÝ LOGIC HIỂN THỊ THẺ
        if (cards.isEmpty()) {
            // Nếu không có thẻ nào
            request.setAttribute("message", "Bộ thẻ này hiện chưa có thẻ nào. Hãy thêm thẻ mới!");
            request.setAttribute("deckId", deckId);
            request.setAttribute("currentCardNumber", 0);
            request.setAttribute("totalCards", 0);
            request.setAttribute("card", null);
        } else {
            // Nếu có thẻ, xử lý chuyển tiếp (next/prev)
            Integer cardIndex = (Integer) session.getAttribute("cardIndex");
            if (cardIndex == null || cardIndex < 0 || cardIndex >= cards.size()) { 
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
        
        // 6. CHUYỂN TIẾP ĐẾN JSP
        // Truyền categoryId (String đã xử lý) vào Request Scope cho JSP sử dụng
        request.setAttribute("categoryId", categoryId); 
        
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