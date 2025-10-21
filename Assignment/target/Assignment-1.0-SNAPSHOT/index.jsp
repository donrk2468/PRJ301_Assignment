<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TEAMWORK ASSIGNMENT</title>
    <link rel="stylesheet" href="css/src/indexStyle.css">
</head>
<body>
    <div class="container">
        <header>
            <div class="navbar">
                <div class="nav-logo">
                    <img src="./css/img/index/teamwork.png" alt="alt"/>
                    <a href="https://daihoc.fpt.edu.vn/" target="_blank">
                        <img src="./css/img/index/logo.png" alt="alt"/>
                    </a>
                </div>
                <div class="nav-menu">
                    <a href="#">Trang chủ</a>
                    <a href="#">Thẻ của tôi</a>
                    <a href="#">Luyện tập</a>
                    <a href="#">Cài đặt</a>
                </div>
                <div class="nav-profile">
                    <%
                        String username = (String) request.getAttribute("username");
                        if (username != null) {
                    %>
                        <span>Xin chào, <%= username %></span>
                        <!-- Bạn có thể thêm link logout -->
                        <a href="logout">Đăng xuất</a>
                    <%
                        } else {
                    %>
                        <a class="nav-login" href="jsp/login.jsp">Login</a>
                    <%
                        }
                    %>
                    <img src="./css/img/index/profile.jpg" alt="alt"/> 
                </div>
            </div>
            <div class="banner">
                <div class="banner-title">Chào mừng bạn!</div>
                <div class="banner-desc">Nhấn vào nút bên dưới để bắt đầu học.</div>
                <a class="main-action" href="homePage">Bắt đầu học</a>
            </div>
        </header>
        <!-- phần footer như cũ -->
    </div>
</body>
<script>
    // Script cập nhật margin banner (giữ nguyên)
</script>
</html>