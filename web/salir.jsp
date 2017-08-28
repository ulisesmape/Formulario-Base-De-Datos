<%-- 
    Document   : salir
    Created on : 28/04/2017, 08:23:54 AM
    Author     : Gerardo Emmanuel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%

HttpSession sss = request.getSession();

sss.removeAttribute("idUsr");
sss.invalidate();

response.sendRedirect("index.html");

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
