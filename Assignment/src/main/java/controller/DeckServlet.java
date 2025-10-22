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

    // Không cần flashcards và init() nữa

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // 1. LẤY deckId TỪ REQUEST HOẶC SESSION
        String deckIdParam = request.getParameter("id");
        Integer deckId = (Integer) session.getAttribute("currentDeckId");
        
        // Nếu có tham số 'id' mới, ưu tiên nó và reset index
        if (deckIdParam != null && !deckIdParam.isEmpty()) {
            try {
                int newDeckId = Integer.parseInt(deckIdParam);
                deckId = newDeckId;
                session.setAttribute("currentDeckId", deckId); // Lưu deckId mới
                session.setAttribute("cardIndex", 0);        // Reset index
            } catch (NumberFormatException e) {
                // Xử lý lỗi nếu ID không hợp lệ
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tham số deckId không hợp lệ.");
                return;
            }
        }
        
        // Nếu không có deckId, chuyển hướng về trang chủ/category
        if (deckId == null) {
            response.sendRedirect(request.getContextPath() + "/homePage"); 
            return;
        }

        // 2. TẢI DANH SÁCH THẺ (CARDS) TỪ DB
        List<Card> cards;
        try {
            DeckDAO deckDAO = new DeckDAO();
            cards = deckDAO.getCardsByDeckId(deckId);
        } catch (SQLException e) {
             Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, "Lỗi truy vấn thẻ.", e);
             response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi truy vấn dữ liệu thẻ.");
             return;
        }

        // 3. XỬ LÝ THEME VÀ I18N (Giữ nguyên logic theme của bạn)
        // ... (Đặt lại logic xử lý ngôn ngữ và theme từ DeckServlet cũ ở đây)
        String themeColorParam = request.getParameter("theme");
        String currentTheme = null; 
        if (themeColorParam != null && !themeColorParam.isEmpty()) {
            Cookie themeCookie = new Cookie("themeColor", themeColorParam);
            themeCookie.setMaxAge(60 * 60 * 24 * 30);
            response.addCookie(themeCookie);
            currentTheme = themeColorParam;
        } else {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("themeColor")) {
                        currentTheme = cookie.getValue();
                        break;
                    }
                }
            }
        }
        if (currentTheme == null) {
            currentTheme = "#007bff"; 
        }
        request.setAttribute("themeColor", currentTheme);
        // --- Kết thúc xử lý Theme ---
        
        // 4. XỬ LÝ CHỈ SỐ THẺ HIỆN TẠI (CARD INDEX)
        Integer cardIndex = (Integer) session.getAttribute("cardIndex");
        if (cardIndex == null) {
            cardIndex = 0;
        }
        
        // Cập nhật index dựa trên action
        String action = request.getParameter("action");
        if ("next".equals(action)) {
            cardIndex++;
            if (cardIndex >= cards.size()) {
                cardIndex = 0; 
            }
        } else if ("prev".equals(action)) {
             cardIndex--;
             if (cardIndex < 0) {
                 cardIndex = cards.size() - 1;
             }
        }

        session.setAttribute("cardIndex", cardIndex);
        
        // 5. GÁN GIÁ TRỊ VÀ CHUYỂN TIẾP
        if (cards.isEmpty()) {
             request.setAttribute("message", "Bộ thẻ này không có flashcard nào.");
             request.setAttribute("currentCardNumber", 0);
             request.setAttribute("totalCards", 0);
        } else {
             // Gán đối tượng model.Card cho JSP
             request.setAttribute("card", cards.get(cardIndex)); 
             request.setAttribute("currentCardNumber", cardIndex + 1);
             request.setAttribute("totalCards", cards.size());
        }

        request.setAttribute("deckId", deckId);
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