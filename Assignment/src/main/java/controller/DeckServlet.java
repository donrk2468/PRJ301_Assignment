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

        // Lấy deckId và categoryId từ Session (dùng cho JSP/URL)
        String deckIdParam = request.getParameter("id");
        Integer deckId = (Integer) session.getAttribute("currentDeckId");
        
        // Cần lấy categoryId để đảm bảo Session có giá trị cho nút quay lại
        Integer categoryIdObj = (Integer) session.getAttribute("categoryId");
        // Không cần chuyển thành String ở đây vì JSP sẽ dùng ${sessionScope.categoryId}
        
        
        // 2. XỬ LÝ deckId TỪ PARAMETER
        if (deckIdParam != null && !deckIdParam.isEmpty()) {
            try {
                int newDeckId = Integer.parseInt(deckIdParam);
                
                if (deckId == null || newDeckId != deckId) {
                    deckId = newDeckId;
                    session.setAttribute("currentDeckId", deckId);
                    session.setAttribute("cardIndex", 0); 
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tham số deckId không hợp lệ.");
                return;
            }
        }

        // 3. KIỂM TRA TÍNH HỢP LỆ CỦA deckId
        if (deckId == null) {
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
            request.setAttribute("message", "Bộ thẻ này hiện chưa có thẻ nào. Hãy thêm thẻ mới!");
            request.setAttribute("deckId", deckId); // Giữ lại deckId trong Request cho Form thêm thẻ
            request.setAttribute("currentCardNumber", 0);
            request.setAttribute("totalCards", 0);
            request.setAttribute("card", null);
        } else {
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
            
            // CHỈ TRUYỀN CÁC BIẾN CẦN THIẾT HOẶC BIẾN DỮ LIỆU ĐỘNG (Request Scope)
            request.setAttribute("card", cards.get(cardIndex));
            request.setAttribute("currentCardNumber", cardIndex + 1);
            request.setAttribute("totalCards", cards.size());
            request.setAttribute("deckId", deckId); // Giữ lại để dùng trong form/liên kết
            
            // KHÔNG CẦN request.setAttribute("categoryId", categoryId) NỮA
        }
        
        // 6. CHUYỂN TIẾP ĐẾN JSP
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