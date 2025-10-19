document.addEventListener('DOMContentLoaded', function() {
    const flashcard = document.getElementById('flashcard');
    const flipBtn = document.getElementById('flip-btn');
    const themePicker = document.getElementById('theme-picker');

    // Lật thẻ khi nhấn nút "Lật" hoặc nhấn vào chính thẻ
    if (flipBtn) {
        flipBtn.addEventListener('click', () => {
            flashcard.classList.toggle('is-flipped');
        });
    }
    
    if (flashcard) {
        flashcard.addEventListener('click', () => {
            flashcard.classList.toggle('is-flipped');
        });
    }

    // Xử lý đổi màu giao diện
    if (themePicker) {
        themePicker.addEventListener('input', (event) => {
            const newColor = event.target.value;
            document.body.style.setProperty('--primary-color', newColor);
        });

        // Gửi màu đã chọn về server khi người dùng chọn xong
        themePicker.addEventListener('change', (event) => {
            const newColor = event.target.value;
            // Bỏ dấu # vì nó không an toàn trong URL
            const colorHex = newColor.replace('#', '');
            window.location.href = `home?theme=%23${colorHex}`;
        });
    }
});