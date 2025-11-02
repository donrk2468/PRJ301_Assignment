<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>TEAMWORK ASSIGNMENT</title>
        <link rel="stylesheet" href="css/src/indexStyle.css">
        <link rel="stylesheet" href="css/src/footer.css">
        <link rel="stylesheet" href="css/src/header.css">
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
                            // Lấy username từ Request Attribute (được set trong HomePageServlet)
                            String username = (String) session.getAttribute("username"); 
        
                            if (username != null) {
                        %>
                        <a href="logout" class="nav-login">Đăng xuất</a>
                        <span class="userName-span"><%= username %></span>
                        <img src="./css/img/index/profile.jpg" alt="alt"/> 
                        <%
                            } else {
                        %>
                        <a class="nav-login" href="jsp/login.jsp">Login</a>
                        <a class="nav-login" href="jsp/register.jsp">Register</a>
                        <%
                            }
                        %>
                    </div>
                    <%
                        List<Category> categoryList = (List<Category>) request.getAttribute("category");
                        if (categoryList != null && !categoryList.isEmpty()) {
                            // Hiển thị danh sách category cá nhân
                        } else {
                            // Hiển thị thông báo chung hoặc lời mời đăng nhập
                            if (username == null) {
                                // "Vui lòng đăng nhập để xem thẻ của bạn."
                            }
                        }
                    %>

                </div>
            </header>
            <div class="banner">
                <div class="banner-title">Chào mừng bạn!</div>
                <div class="banner-desc">Nhấn vào nút bên dưới để bắt đầu học.</div>
                <a class="main-action" href="CategoryDirect">Bắt đầu học</a>
            </div>
            <footer class="footer">
                <div class="footer-container">
                    <div class="footer-column about">
                        <h3>Flashcard Tiếng Nhật</h3>
                        <p>Nền tảng giúp bạn học từ vựng tiếng Nhật hiệu quả thông qua các bộ thẻ ghi nhớ thông minh.</p>
                        <p><i class="fa fa-map-marker-alt"></i> Địa chỉ: Hà Nội, Việt Nam</p>
                        <!--<p><i class="fa fa-phone"></i> Điện thoại: </p>-->
                        <p><i class="fa fa-envelope"></i> Email: steamactive123@gmail.com</p>
                    </div>

                    <div class="footer-column links">
                        <h3>Liên kết nhanh</h3>
                        <ul>
                            <li><a href="#">Về chúng tôi</a></li>
                            <li><a href="#">Câu hỏi thường gặp (FAQ)</a></li>
                            <li><a href="#">Chính sách bảo mật</a></li>
                            <li><a href="#">Điều khoản dịch vụ</a></li>
                        </ul>
                    </div>

                    <div class="footer-column social">
                        <h3>Kết nối với chúng tôi</h3>
                        <div class="social-icons">
                            <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-youtube"></i></a>
                        </div>
                        <h4 class="newsletter-title">Đăng ký nhận tin</h4>
                        <form class="newsletter-form">
                            <input type="email" placeholder="Nhập email của bạn...">
                            <button type="submit">Đăng ký</button>
                        </form>
                    </div>
                </div>
                <div class="footer-bottom">
                    <p>© 2025 Flashcard Tiếng Nhật. Mọi quyền được bảo lưu.</p>
                </div>
            </footer>
        </div>
    </body>
    <script>
        function updateBannerMargin() {
            const banner = document.querySelector(".banner");
            if (!banner)
                return;

            const style = getComputedStyle(banner);
            const paddingTop = parseFloat(style.paddingTop);
            const paddingBottom = parseFloat(style.paddingBottom);
            const height = banner.offsetHeight;

            // Tính margin-top theo công thức bạn muốn
            const marginTop = window.innerHeight / 2 - (paddingTop + paddingBottom + height);

            // Tính margin-bottom = 50vh - 60px
            const marginBottom = 5;

            banner.style.marginTop = `${marginTop}px`;
            banner.style.marginBottom = `${marginBottom}%`;
        }

        // Gọi 1 lần khi trang load
        window.addEventListener("load", updateBannerMargin);

        // Gọi lại khi resize
        window.addEventListener("resize", updateBannerMargin);
    </script>
</html>