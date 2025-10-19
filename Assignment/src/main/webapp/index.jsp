<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'vi'}">
<head>
    <meta http-equiv="Conte nt-Type" content="text/html; charset=UTF-8">
    <title>${messages['app.title']}</title>
    <link rel="stylesheet" href="css/src/homeStyle.css">
</head>
<body style="--primary-color: ${themeColor != null ? themeColor : '#007bff'}">

    <div class="app-container">
        <header class="app-header">
            <h1>${messages['app.title']}</h1>
            <div class="controls">
                <div class="language-switcher">
                    <a href="home?lang=vi" class="${sessionScope.lang == 'vi' || sessionScope.lang == null ? 'active' : ''}">VIE</a> |
                    <a href="home?lang=en" class="${sessionScope.lang == 'en' ? 'active' : ''}">ENG</a>
                </div>
                <div class="theme-selector">
                    <label for="theme-picker">${messages['theme.color']}:</label>
                    <input type="color" id="theme-picker" value="${themeColor != null ? themeColor : '#007bff'}">
                </div>
            </div>
        </header>

        <main class="flashcard-container">
            <div class="flashcard" id="flashcard">
                <div class="card-face card-front">
                    <p class="japanese-word">${card.japaneseWord}</p>
                </div>
                <div class="card-face card-back">
                    <p class="romaji">${card.romaji}</p>
                    <p class="meaning">${card.vietnameseMeaning}</p>
                </div>
            </div>
        </main>

        <footer class="app-footer">
            <button id="flip-btn" class="action-btn">${messages['button.flip']}</button>
            <a href="home?action=next" class="action-btn">${messages['button.next']}</a>
        </footer>
    </div>

    <script src="js/script.js"></script>
</body>
</html>