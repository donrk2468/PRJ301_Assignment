<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách Thẻ của tôi</title>
    </head>
    <body>

        <%
            // Lấy username đã truyền từ Servlet (để hiển thị lời chào)
            String username = (String) request.getAttribute("username"); 
        
            // Lấy danh sách Category đã truyền từ Servlet
            List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
        %>

        <h1>Chào mừng, <%= username != null ? username : "Người dùng" %>!</h1>
        <h2>Thẻ của bạn</h2>

        <%
            if (categoryList != null && !categoryList.isEmpty()) {
        %>
        <ul>
            <% 
                for (Category c : categoryList) {
            %>
            <p>
                <a href="category?id=<%=c.getCategoryId()%>"><%=c.getCategoryName()%></a>
            </p>
            <%
                }
            %>
        </ul>
        <%
            } else {
        %>
        <p>Bạn chưa có bộ thẻ nào. Hãy tạo một bộ thẻ mới để bắt đầu học!</p>
        <%
            }
        %>

    </body>
</html>