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
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date dataInizioIn = Date.valueOf(request.getParameter("dataInizio"));
            Date dataFineIn = Date.valueOf(request.getParameter("dataFine"));
            String categoriaIn = request.getParameter("categoria");
            String provinciaIn = request.getParameter("provincia");

            Connection conn = null;
            PreparedStatement st = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
                conn = DriverManager.getConnection("jdbc:mysql://localhost/gestione_eventi_compito?user=root");
                st = conn.prepareStatement("SELECT * FROM eventi WHERE dataInizio=? AND dataFine=? AND categoria=? AND provincia=?");
                st.setDate(1, dataInizioIn);
                st.setDate(2, dataFineIn);
                st.setString(3, categoriaIn);
                st.setString(4, provinciaIn);
                rs = st.executeQuery();
        %>

        <h2>Eventi che rientrano nei filtri che hai inserito:</h2>
        
        <table border="1" cellspacing="1" cellpadding="3">
            <tr><td>Id</td><td>dataInizio</td><td>dataFine</td><td>categoria</td><td>descrizione</td><td>provincia</td></tr>
            <% while (rs.next()) {
                    int id = rs.getInt(1);
                    String dataInizioOut = dateFormat.format(rs.getDate(2));
                    String dataFineOut = dateFormat.format(rs.getDate(3));
                    String provinciaOut = rs.getString(4);
                    String descrizione = rs.getString(5);
                    String categoriaOut = rs.getString(6);
            %>
            <tr><td><%=id%></td><td><%=dataInizioOut%></td><td><%=dataFineOut%></td><td><%=categoriaOut%></td><td><%=descrizione%></td><td><%=provinciaOut%></td></tr>
            <%}%>
        </table> 
        <br>
        <h2>Inserimento commenti</h2>
        <h3>Inserisci i seguenti campi per pubblicare un commento:</h3>
        <form action="gestione_commenti_eventi.jsp">
            <table border="1" cellspacing="1" cellpadding="3">
                <tr>
                    <td>ID evento:</td>
                    <td><input type="text" name="codEvento"/></td>
                </tr>
                <tr>
                    <td>Username:</td>
                    <td><input type="text" name="nomeUtente"/></td>
                </tr>
                <tr>
                    <td>Voto [1(Peggiore)-5(Migliore)]:</td>
                    <td><input type="int" name="voto"/></td>
                </tr>
                <tr>
                    <td>Commento:</td>
                    <td><textarea type="text" name="commento" rows="4" cols="50"></textarea></td>
                </tr>
            </table> 
            <br>
            <input type="submit" value="Pubblica commento"/>
        </form>

        <br>
        <h2>Visualizzazione commenti</h2>
        <h3>Inserisci i seguenti campi per visualizzare i commenti:</h3>
        <form action="gestione_visualizzazione_commenti.jsp">
            <table border="1" cellspacing="1" cellpadding="3">
                <tr><td>ID evento:</td>
                    <td><input type="text" name="codEvento"/></td></tr>
            </table> 
            <br>
            <input type="submit" value="Visualizza commenti"/>
        </form>
        <table border="0" cellspacing="1" cellpadding="3">
            <td><form action="ricerca_eventi.jsp">
                    <input type="submit" value="Cerca un altro evento"/>
                </form></td>
            <br>
            <td><form action="index.html">
                    <input type="submit" value="Torna alla home"/>
                </form></td>
        </table> 
        <% } catch (SQLException ex) {
                out.println(ex);
            } catch (ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
                out.println(ex);
            }
            try {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                out.println(ex);
            }
        %>

    </body>
</html>
