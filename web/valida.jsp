 <%-- 
    Document   : valida
    Created on : 21/04/2017, 08:17:28 AM
    Author     : Gerardo Emmanuel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%

String btnEntrar = request.getParameter("btnEntrar");


if(btnEntrar != null){
    String usr = request.getParameter("usuario")== null?"0":request.getParameter("usuario");
    String psw = request.getParameter("psw")== null?"0":request.getParameter("psw");
    
    if(usr.equals("0") || psw.equals("0")){
        response.sendRedirect(".");
    }       
    
    controlador.cUsuario per = new controlador.cUsuario(usr, psw);
    
    if(!per.validaUsr()){
        out.print(per.ERROR());
    }
    else{

        //para ingresar al sistema
        HttpSession xSes = request.getSession(true);
        
        xSes.setAttribute("idUsr", per.IDUSR());
        
        response.sendRedirect("principal.jsp");
    }
}
else{
    String btnRegistrar = request.getParameter("btnReg");
    if(btnRegistrar != null){
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String psw = request.getParameter("psw2");
        String mail = request.getParameter("mail");
        
        String[] varios = request.getParameterValues("genero");
        //out.print(varios.toString());
        
        controlador.cUsuario perX = new controlador.cUsuario();
        
        if(perX.RgistraUSR(nombre, apellidos, psw, mail, 'x', "")){
            
            out.println(perX.IDUSR());
            out.println(perX.NOMBREPERSONA());
        }
            
        
        
    }
    
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
