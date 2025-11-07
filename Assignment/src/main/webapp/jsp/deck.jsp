<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Các bộ thẻ</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/src/style.css">
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
            <a href="${pageContext.request.contextPath}/CategoryDirect" class="back-link">&larr; Quay lại các chủ đề</a>
            <h2>Chọn một bộ thẻ để học</h2>

            <c:choose>
                <c:when test="${not empty deck}">
                    <div class="item-grid">
                        <c:forEach var="d" items="${deck}">
                            <div class="item-card category-card" data-deck-id="${d.deckId}" data-category-id="${d.categoryId}">
                                <div class="actions" style="flex-direction: column; align-items: flex-start;">

                                    <form action="updateDeck" method="post" class="update-form" style="display:flex; flex-direction: column; width: 100%;">
                                        <input type="hidden" name="deckId" value="${d.deckId}"/>
                                        <input type="hidden" name="categoryId" value="${d.categoryId}"/>

                                        <input type="text"
                                               name="deckName"
                                               value="${d.deckName}"
                                               class="category-name-input" data-original-value="${d.deckName}"
                                               readonly/>

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
                                    <a href="${pageContext.request.contextPath}/deck?id=${d.deckId}&categoryId=${d.categoryId}"
                                       class="btn btn-primary btn-success toggle-button" 
                                       style="padding: 5px 10px; margin-top: 10px; background: #0d6efd;">
                                        Truy Cập
                                    </a>
                                    <a href="deleteDeck?id=${d.deckId}&categoryId=${d.categoryId}"
                                       onclick="return confirm('Bạn có chắc muốn xóa bộ thẻ này?');"
                                       class="btn btn-danger delete-link" 
                                       style="padding: 5px 10px; margin-top: 10px;">
                                        Xóa
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>  
                </c:when>
                <c:otherwise>
                    <p style="padding: 2rem; background-color: #e9ecef; border-radius: 8px; text-align: center;">Chủ đề này chưa có bộ thẻ nào. Hãy tạo một bộ thẻ mới bên dưới!</p>
                </c:otherwise>
            </c:choose>

            <div class="form-container">
                <h3>Thêm bộ thẻ mới</h3>
                <form action="addDeck" method="post" class="form-inline">
                    <input type="hidden" name="categoryId" value="${categoryId}">
                    <div class="form-group">
                        <input type="text" name="deckName" class="form-control" placeholder="Tên bộ thẻ mới" required>
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

            // --- 1. XỬ LÝ NÚT SỬA (.btn-sua) ---
            if (event.target.classList.contains('btn-sua')) {
                const btnSua = event.target;
                const form = btnSua.closest('.update-form');
                const btnLuu = form.querySelector('.btn-luu');
                const btnHuy = form.querySelector('.btn-huy');
                const inputName = form.querySelector('.category-name-input');

                // Chuyển đổi trạng thái nút
                btnSua.style.display = 'none';
                btnLuu.style.display = 'inline-block';
                btnHuy.style.display = 'inline-block';

                // Kích hoạt sửa
                inputName.removeAttribute('readonly');
                inputName.focus();
                return; // Dừng lại, không xử lý chuyển hướng
            }

            // --- 2. XỬ LÝ NÚT HỦY (.btn-huy) ---
            else if (event.target.classList.contains('btn-huy')) {
                const btnHuy = event.target;
                const form = btnHuy.closest('.update-form');
                const btnSua = form.querySelector('.btn-sua');
                const btnLuu = form.querySelector('.btn-luu');
                const inputName = form.querySelector('.category-name-input');

                // Khôi phục giá trị
                const originalValue = inputName.getAttribute('data-original-value');
                inputName.value = originalValue;

                // Chuyển về trạng thái ban đầu
                btnSua.style.display = 'inline-block';
                btnLuu.style.display = 'none';
                btnHuy.style.display = 'none';
                inputName.setAttribute('readonly', 'readonly');
                event.preventDefault(); // Ngăn hành vi submit form nếu có
                return; // Dừng lại, không xử lý chuyển hướng
            }

            // --- 3. XỬ LÝ CHUYỂN HƯỚNG KHI NHẤP VÀO CARD ---

            // Tìm thẻ item-card gần nhất từ điểm click
            const card = event.target.closest('.category-card');

            // Kiểm tra xem click có xảy ra trên các phần tử tương tác không
            const isInteractive = event.target.closest('.actions') ||
                    event.target.closest('.update-form') ||
                    event.target.closest('.delete-link');

            // Nếu click trúng vào card VÀ KHÔNG trúng vào các phần tử tương tác
            if (card && !isInteractive) {
                // Lấy ID bộ thẻ (deckId) và Category ID
                const deckId = card.getAttribute('data-deck-id');
                const categoryId = card.getAttribute('data-category-id');
                const inputElement = card.querySelector('.category-name-input');

                // CHỈ CHUYỂN HƯỚNG NẾU KHÔNG Ở CHẾ ĐỘ SỬA (input là readonly)
                if (deckId && categoryId && inputElement && inputElement.hasAttribute('readonly')) {
                    // Chuyển hướng đến trang chi tiết bộ thẻ
                    window.location.href = `${contextPath}/deck?id=${deckId}&categoryId=${categoryId}`;
                                }
                            }
                        });
    </script>
</html>