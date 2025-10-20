<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.prj103.flashcard.model.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Flashcard App - Home</title>
        <link rel="stylesheet" href="css/style.css"/>
    </head>
    <body>
        <h1>📚 Thư viện học Flashcard</h1>

        <ul>
            <%
                List<Category> categories = (List<Category>) request.getAttribute("category");
                List<Card> cards = (List<Card>) request.getAttribute("cards");
            
                for (Card ca : cards) {
            %>
            <li>
                <%= ca.getCardId() %>
            </li>
            <% } %>

            <h2>Danh mục (Categories)</h2>
            <%
                if (categories != null && !categories.isEmpty()) {
                    for (Category c : categories) {
            %>
            <li>
                <a href="category?id=<%= c.getCategoryId() %>">
                    <%= c.getCategoryName() %>
                </a>
            </li>
            <%
                    }
                } else {
            %>
            <li>Không có danh mục nào.</li>
                <% } %>
        </ul>
    </body>
</html>
