<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.*" %>
<html>
    <head><title>Decks</title></head>
    <body>
        <h2>📂 Các bộ thẻ</h2>
        <ul>
            <%
                List<Deck> list = (List<Deck>) request.getAttribute("deck");
                for(Deck d : list) {
            %>
            <li>
                <a href="deck?id=<%=d.getDeckId()%>"><%=d.getDeckName()%></a>
            </li>
            <% } %>
        </ul>
    </body>
</html>
