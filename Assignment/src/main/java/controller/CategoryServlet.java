package controller;

import model.Deck;
import dal.DeckDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "category", urlPatterns = {"/category"})
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. LẤY categoryId TỪ REQUEST
        String categoryIdParam = request.getParameter("id");
        HttpSession session = request.getSession(true);
        Integer categoryId = null;

        // Xử lý tham số 'id'
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                // Chuyển đổi sang kiểu Integer
                categoryId = Integer.parseInt(categoryIdParam);
                
                // LƯU categoryId MỚI LÊN SESSION
                session.setAttribute("categoryId", categoryId);
                
            } catch (NumberFormatException e) {
                // Nếu tham số không phải là số, xem là yêu cầu không hợp lệ
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID danh mục không hợp lệ.");
                return;
            }
        } else {
            // 2. NẾU KHÔNG CÓ THAM SỐ 'id', THỬ LẤY TỪ SESSION
            categoryId = (Integer) session.getAttribute("categoryId");
        }

        // 3. KIỂM TRA: Nếu categoryId vẫn null hoặc không hợp lệ, chuyển về trang chủ
        if (categoryId == null || categoryId <= 0) {
            // Chuyển hướng về trang chủ hoặc trang hiển thị các Category
            response.sendRedirect(request.getContextPath() + "/homePage");
            return;
        }

        // 4. LẤY DANH SÁCH DECK
        DeckDAO dao = new DeckDAO();
        List<Deck> list = dao.getDecksByCategory(categoryId);

        // 5. CHUYỂN TIẾP
        request.setAttribute("deck", list);
        request.setAttribute("categoryId", categoryId); // Truyền lại ID cho JSP sử dụng
        request.getRequestDispatcher("jsp/deck.jsp").forward(request, response);
    }
}