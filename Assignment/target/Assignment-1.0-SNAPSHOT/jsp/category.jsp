<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chủ đề của bạn</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/src/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/src/footer.css">        
    </head>
    <body>
        <header class="main-header">
            <a href="${pageContext.request.contextPath}/homePage" class="logo">Flashcard</a>
            <div class="user-info">
                <span>Chào, ${sessionScope.username}</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Đăng xuất</a>
            </div>
        </header>
        <div class="container">
            <a href="${pageContext.request.contextPath}/homePage" class="back-link">&larr; Quay lại Trang Chủ</a>
            <h2>Chủ đề của bạn</h2>
            <div class="item-grid">
                <c:forEach var="cat" items="${categoryList}">
                    <a href="${pageContext.request.contextPath}/category?id=${cat.categoryId}" class="item-card">
                        <h3>${cat.categoryName}</h3>
                    </a>
                </c:forEach>
            </div>
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
    </body>
</html>
