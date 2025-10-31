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
        // Lấy categoryId từ URL
        int categoryId = Integer.parseInt(request.getParameter("id"));

        // Lấy danh sách deck (có thể rỗng)
        DeckDAO dao = new DeckDAO();
        List<Deck> list = dao.getDecksByCategory(categoryId);

        request.setAttribute("deck", list);
        request.setAttribute("categoryId", categoryId);
        request.getRequestDispatcher("jsp/deck.jsp").forward(request, response);
    }
}
