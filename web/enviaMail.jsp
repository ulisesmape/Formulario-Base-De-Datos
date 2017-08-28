<%-- 
    Document   : enviaMail
    Created on : 28/04/2017, 08:51:26 AM
    Author     : Gerardo Emmanuel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%


ldn.cMail mail = new ldn.cMail();

String para = "yaz_whiteangel@hotmail.com";
String msj = "ola k ase yaz";
String titulo = "titulo";

if(mail.mandaMail(para, titulo, msj)){
    
}
else{
    
}




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
