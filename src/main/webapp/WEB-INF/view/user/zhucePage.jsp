<%--
  Created by IntelliJ IDEA.
  User: lyq
  Date: 2019/7/1
  Time: 10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
        注册页面
        ${msg}
        <form method="post" action="/user/zhuce">
            用户名：<input type="text" name="userName">
            密码：<input type="password" name="userPswd">
            <input type="submit" value="注册">
            <a href="/user/toLoginPage">登陆页面</a>
        </form>
</body>
</html>
