<%-- 
    Document   : pruebaBD
    Created on : 27-abr-2017, 7:51:23
    Author     : Gerardo Emmanuel
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

String strMascotas = "";
String msj="";
String strNombre = request.getParameter("nombre");
BD.cDatos bd = new BD.cDatos();
try{
    bd.conectar();
        
    /*
    
    ResultSet rsTipoMascota = bd.consulta("select * from personas where nombre = '"+strNombre+"'");
    strMascotas = "<table>";
    while(rsTipoMascota.next()){
        strMascotas += "<tr>";
        strMascotas += "<td>";
        strMascotas += "<a href=\"algo.jsp?war=" + Double.parseDouble(rsTipoMascota.getString("mascotaTipoId")) *3.6 + "\">" + rsTipoMascota.getString("mascotaTipo") + "</a>";
        strMascotas += "</td>";
        strMascotas += "</tr>";
    }
    strMascotas += "</table>";
    */
    
    ResultSet rsTipoMascota = bd.consulta("call spNombre('"+strNombre+"')");
    
    strMascotas = "<table>";
    while(rsTipoMascota.next()){
        strMascotas += "<tr>";
        strMascotas += "<td>";
        strMascotas += "<a href=\"algo.jsp?war=" + Double.parseDouble(rsTipoMascota.getString("personaId")) *3.6 + "\">" + rsTipoMascota.getString("nombre") + "</a>";
        strMascotas += "</td>";
        strMascotas += "</tr>";
    }
    strMascotas += "</table>";
    
    
    bd.cierraConexion();
    
    
}
catch(Exception xxxxxxxD){
    msj = xxxxxxxD.getMessage();
}

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>catalogo de mascotas</h1>
        <hr />
        <%=msj%>
    </body>
</html>
