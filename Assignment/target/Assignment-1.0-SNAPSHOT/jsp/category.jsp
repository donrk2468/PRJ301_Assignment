<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chủ đề của bạn</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/src/style.css">
</head>
<body>
    <header class="main-header">
        <a href="${pageContext.request.contextPath}/homePage" class="logo">Flashcard</a>
        <div class="user-info">
            <span>Chào, ${username}</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Đăng xuất</a>
        </div>
    </header>
    <div class="container">
        <h2>Chủ đề của bạn</h2>
        <div class="item-grid">
            <c:forEach var="cat" items="${categoryList}">
                <div class="item-card">
                    <a href="${pageContext.request.contextPath}/category?id=${cat.categoryId}" style="text-decoration:none; color:inherit;">
                        <h3>${cat.categoryName}</h3>
                    </a>
                    <div class="actions">
                        <form action="updateCategory" method="post">
                            <input type="hidden" name="categoryId" value="${cat.categoryId}">
                            <input type="text" name="categoryName" value="${cat.categoryName}" class="form-control" style="padding: 5px; flex-grow: 1;">
                            <button type="submit" class="btn btn-primary" style="padding: 5px 10px;">Lưu</button>
                        </form>
                        <a href="deleteCategory?id=${cat.categoryId}" onclick="return confirm('Bạn có chắc muốn xóa chủ đề này?');" class="btn btn-danger" style="padding: 5px 10px;">Xóa</a>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="form-container">
            <h3>Thêm chủ đề mới</h3>
            <form action="addCategory" method="post" class="form-inline">
                <div class="form-group">
                    <input type="text" name="categoryName" class="form-control" placeholder="Tên chủ đề mới" required>
                </div>
                <button type="submit" class="btn btn-primary">Thêm</button>
            </form>
        </div>
    </div>
</body>
</html>