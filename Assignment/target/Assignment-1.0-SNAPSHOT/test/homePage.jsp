<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.prj103.flashcard.model.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Flashcard App - Home</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
    <h1>📚 Thư viện học Flashcard</h1>
    <h2>Danh mục (Categories)</h2>
    <p><a href="index.html">Back to homepage</a> </p>
    <ul>
        <%
            List<Category> categories = (List<Category>) request.getAttribute("categories");
            if (categories != null && !categories.isEmpty()) {
                for (Category c : categories) {
        %>
            <li>
                <a href="category?categoryId=<%= c.getCategoryId() %>">
                    <%= c.getName() %>
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
