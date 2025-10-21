<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Login Page</h1>
        <form action="${pageContext.request.contextPath}/login2" method="post">
            <p>
                <input name="email" placeholder="Email"/>
            </p>
            <p>
                <input name="password" placeholder="Password"/>
            </p>
            <p>
                <input type="submit" value="Login">
            </p>
        </form>
        
    </body>
</html>
