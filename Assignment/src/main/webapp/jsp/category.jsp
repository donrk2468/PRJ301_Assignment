<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.prj103.flashcard.model.Category" %>
<html>
    <head><title>Danh mục</title></head>
    <body>
        <h2>📚 Danh mục thẻ học</h2>
        <ul>
            <%
                List<Category> list = (List<Category>) request.getAttribute("category");
                for(Category c : list) {
            %>
            <li>
                <a href="category?id=<%=c.getCategoryId()%>"><%=c.getCategoryName()%></a>
            </li>
            <% } %>
        </ul>
    </body>
</html>
