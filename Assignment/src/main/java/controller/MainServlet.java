package controller;

import model.Flashcard;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(name = "home", urlPatterns = {"/home"})     
public class MainServlet extends HttpServlet {

    private List<Flashcard> flashcards;

    @Override
    public void init() throws ServletException {
        // Khởi tạo dữ liệu mẫu
        flashcards = new ArrayList<>();
        flashcards.add(new Flashcard("こんにちは", "Konnichiwa", "Xin chào"));
        flashcards.add(new Flashcard("ありがとう", "Arigatou", "Cảm ơn"));
        flashcards.add(new Flashcard("はい", "Hai", "Vâng / Đúng"));
        flashcards.add(new Flashcard("いいえ", "Iie", "Không"));
        flashcards.add(new Flashcard("日本", "Nihon", "Nhật Bản"));
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // --- 1. Xử lý ngôn ngữ (i18n) ---
        String lang = request.getParameter("lang");
        if (lang != null) {
            session.setAttribute("lang", lang);
        }
        String sessionLang = (String) session.getAttribute("lang");
        if (sessionLang == null) {
            sessionLang = "vi"; // Ngôn ngữ mặc định
        }

        Locale locale = new Locale(sessionLang);
        ResourceBundle messages = ResourceBundle.getBundle("i18n.messages", locale);
        request.setAttribute("messages", messages);

        // --- 2. Xử lý màu giao diện (Theme) ---
        String themeColor = request.getParameter("theme");
        if (themeColor != null && !themeColor.isEmpty()) {
            Cookie themeCookie = new Cookie("themeColor", themeColor);
            themeCookie.setMaxAge(60 * 60 * 24 * 30); // 30 ngày
            response.addCookie(themeCookie);
            request.setAttribute("themeColor", themeColor);
        } else {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("themeColor")) {
                        request.setAttribute("themeColor", cookie.getValue());
                        break;
                    }
                }
            }
        }
        
        // --- 3. Xử lý hiển thị Flashcard ---
        Integer cardIndex = (Integer) session.getAttribute("cardIndex");
        if (cardIndex == null) {
            cardIndex = 0;
        }

        // Chuyển sang thẻ tiếp theo khi có yêu cầu (ví dụ: người dùng nhấn "Next")
        String action = request.getParameter("action");
        if ("next".equals(action)) {
            cardIndex++;
            if (cardIndex >= flashcards.size()) {
                cardIndex = 0; // Quay lại thẻ đầu tiên
            }
        }
        
        session.setAttribute("cardIndex", cardIndex);
        request.setAttribute("card", flashcards.get(cardIndex));

        // Chuyển tiếp tới trang JSP để hiển thị
        request.getRequestDispatcher("jsp/index.jsp").forward(request, response);
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