<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestione eventi</title>
    </head>
    <body>

        <%
            Date dataInizioIn = Date.valueOf(request.getParameter("dataInizio"));
            Date dataFineIn = Date.valueOf(request.getParameter("dataFine"));
            String categoriaIn = request.getParameter("categoria");
            String provinciaIn = request.getParameter("provincia");
            String descrizioneIn = request.getParameter("descrizione");

            Connection conn = null;
            PreparedStatement st = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
                conn = DriverManager.getConnection("jdbc:mysql://localhost/gestione_eventi_compito?user=root");
                st = conn.prepareStatement("INSERT INTO eventi (dataInizio, dataFine, provincia, descrizione, categoria) VALUES (?, ?, ?, ?, ?)");
                st.setDate(1, dataInizioIn);
                st.setDate(2, dataFineIn);
                st.setString(3, provinciaIn);
                st.setString(4, descrizioneIn);
                st.setString(5, categoriaIn);
                st.executeUpdate();
        %>
        
        <br>
        <h2>Inserimento andato a buon fine!</h2>
        <table border="0" cellspacing="1" cellpadding="3">
            <form action="index.html">
                <tr><td colspan="2"><input type="submit" value="Torna alla home"/></td>
            </form>
            <form action="inserimento_eventi.jsp">
                <td colspan="2"><input type="submit" value="Inserisci un altro evento"/></td></tr>
            </form>
        </table> 

        <% } catch (SQLException ex) {
                out.println(ex);
            } catch (ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
                out.println(ex);
            }
        %>

    </body>
</html>
