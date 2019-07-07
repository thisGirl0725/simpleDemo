<%--
  Created by IntelliJ IDEA.
  User: lyq
  Date: 2019/7/1
  Time: 10:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
        登陆页面

        <form method="post" action="/user/login2">
            ${msg}
            <br>
            用户名：<input type="text" name="userName">
            密码：<input type="password" name="userPswd">
            <input type="submit" value="登陆">
            <a href="/user/toZhucePage2">没有账号？点击登陆</a>>
        </form>
</body>
</html>
