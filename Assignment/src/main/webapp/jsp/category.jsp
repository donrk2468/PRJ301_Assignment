<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %> 
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
            <c:choose>
                <c:when test="${not empty categoryList}">

                    <div class="item-grid">
                        <c:forEach var="cat" items="${categoryList}">
                            <div class="item-card data-category-id">

                                <div class="actions" style="flex-direction: column; align-items: flex-start;"> 
                                    <form action="updateCategory" method="post" class="update-form" style="display:flex; flex-direction: column; width: 100%;">
                                        <input type="hidden" name="categoryId" value="${cat.categoryId}"/>
                                        <input type="text" 
                                               name="categoryName" 
                                               value="${cat.categoryName}" 
                                               class="category-name-input" 
                                               data-original-value="${cat.categoryName}" readonly/> 

                                        <div class="edit-buttons" style="display: flex; flex-direction: row; gap: 10px; margin-top: 10px;">

                                            <button type="button" 
                                                    class="btn btn-primary toggle-button btn-sua" 
                                                    style="padding: 5px 10px;">
                                                Sửa tên
                                            </button>

                                            <button type="submit" 
                                                    class="btn btn-primary btn-success toggle-button btn-luu" 
                                                    style="padding: 5px 10px; display: none;">
                                                Lưu
                                            </button>

                                            <button type="button" 
                                                    class="btn btn-secondary toggle-button btn-huy" 
                                                    style="padding: 5px 10px; display: none;">
                                                Hủy
                                            </button>

                                        </div>
                                    </form>
                                    <a href="${pageContext.request.contextPath}/category?id=${cat.categoryId}"
                                       class="btn btn-primary btn-success toggle-button" 
                                       style="padding: 5px 10px; margin-top: 10px; background: #0d6efd;">
                                        Truy Cập
                                    </a>
                                    <a href="deleteCategory?id=${cat.categoryId}" 
                                       onclick="return confirm('Bạn có chắc muốn xóa chủ đề này?');" 
                                       class="btn btn-danger" 
                                       style="padding: 5px 10px; margin-top: 10px;">
                                        Xóa
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                </div>
                    </c:when>
                <c:otherwise>
                    <p style="padding: 2rem; background-color: #e9ecef; border-radius: 8px; text-align: center;">Chủ đề này chưa có thư mục nào. Hãy tạo một bộ thẻ mới bên dưới!</p>
                </c:otherwise>
            </c:choose>

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
    <script>
        // Context Path (Lấy từ JSP để dùng trong JS)
        const contextPath = '${pageContext.request.contextPath}';

        document.body.addEventListener('click', function (event) {

            // ... (Logic xử lý nút Sửa, Lưu, Hủy cũ) ...

            // -------------------------------------------------------------------
            // 3. XỬ LÝ CHUYỂN HƯỚNG KHI NHẤP VÀO CARD (NGOẠI TRỪ CÁC NÚT TƯƠNG TÁC)
            // -------------------------------------------------------------------

            // Tìm thẻ item-card gần nhất từ điểm click
            const card = event.target.closest('.category-card');

            // Kiểm tra xem click có xảy ra trên các phần tử tương tác (actions, form, input, link xóa) không
            const isInteractive = event.target.closest('.actions') ||
                    event.target.closest('.update-form') ||
                    event.target.classList.contains('category-name-input') ||
                    event.target.classList.contains('delete-link');

            // Nếu click trúng vào card VÀ KHÔNG trúng vào các phần tử tương tác
            if (card && !isInteractive) {
                const categoryId = card.getAttribute('data-category-id');
                if (categoryId) {
                    // Chuyển hướng
                    window.location.href = `${contextPath}/category?id=${categoryId}`;
                                }
                            }
                        });

                        // (Giữ nguyên logic xử lý nút Sửa và Hủy đã có)
                        // -------------------------------------------------------------------
                        // ... Khối JavaScript xử lý nút SỬA và HỦY (như câu trả lời trước) ...
                        // -------------------------------------------------------------------

                        // Ví dụ: Logic Sửa cũ (Đặt lại vào đây)
                        document.body.addEventListener('click', function (event) {
                            // ... (Logic SỬA)
                            if (event.target.classList.contains('btn-sua')) {
                                const btnSua = event.target;
                                const form = btnSua.closest('.update-form');
                                const btnLuu = form.querySelector('.btn-luu');
                                const btnHuy = form.querySelector('.btn-huy');
                                const inputName = form.querySelector('.category-name-input');
                                btnSua.style.display = 'none';
                                btnLuu.style.display = 'inline-block';
                                btnHuy.style.display = 'inline-block';
                                inputName.removeAttribute('readonly');
                                inputName.focus();
                            }

                            // ... (Logic HỦY)
                            else if (event.target.classList.contains('btn-huy')) {
                                const btnHuy = event.target;
                                const form = btnHuy.closest('.update-form');
                                const btnSua = form.querySelector('.btn-sua');
                                const btnLuu = form.querySelector('.btn-luu');
                                const inputName = form.querySelector('.category-name-input');
                                const originalValue = inputName.getAttribute('data-original-value');
                                inputName.value = originalValue;
                                btnSua.style.display = 'inline-block';
                                btnLuu.style.display = 'none';
                                btnHuy.style.display = 'none';
                                inputName.setAttribute('readonly', 'readonly');
                                event.preventDefault();
                            }

                            // Khối logic CHUYỂN HƯỚNG mới
                            const card = event.target.closest('.category-card');
                            const isInteractive = event.target.closest('.actions') ||
                                    event.target.closest('.update-form') ||
                                    event.target.classList.contains('category-name-input') ||
                                    event.target.classList.contains('delete-link');

                            if (card && !isInteractive) {
                                const categoryId = card.getAttribute('data-category-id');
                                if (categoryId) {
                                    window.location.href = `${contextPath}/category?id=${categoryId}`;
                                                }
                                            }
                                        });
    </script>
</html>