<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Inserimento evento</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h3>Inserisci i seguenti campi per inserire il nuovo evento:</h3>
        <form action="gestione_inserimento_eventi.jsp">
            <table>
                <tr><td>Data inizio [aaaa-mm-gg]</td>
                    <td><input type="text" name="dataInizio"/></td></tr>
                <tr><td>Data fine [aaaa-mm-gg]</td>
                    <td><input type="text" name="dataFine"/></td></tr>
                <tr><td>Categoria</td>
                    <td><input type="text" name="categoria"/></td></tr>
                <tr><td>Provincia</td>
                    <td><input type="text" name="provincia"/></td></tr>
                <tr><td>Descrizione dell'evento</td>
                    <td><textarea type="text" name="descrizione" rows="4" cols="50"></textarea></td></tr>
                <td></td>
                <tr><td colspan="2"><input type="submit" value="Inserisci"/></td></tr>
                <td></td>
            </table>  
        </form>
        <form action="index.html">
            <input type="submit" value="Torna alla home"/>
        </form>
    </body>
</html>
