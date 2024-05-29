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
        <title>Gestione commenti</title>
    </head>
    <body>

        <%
            String commentoIn = request.getParameter("commento");
            int votoIn = Integer.parseInt(request.getParameter("voto"));
            int codEventoIn = Integer.parseInt(request.getParameter("codEvento"));
            String usernameIn = request.getParameter("nomeUtente");

            Connection conn = null;
            PreparedStatement st = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
                conn = DriverManager.getConnection("jdbc:mysql://localhost/gestione_eventi_compito?user=root");
                st = conn.prepareStatement("INSERT INTO commenti (testo, voto, codEvento, nomeUtente) VALUES (?, ?, ?, ?)");
                st.setString(1, commentoIn);
                st.setInt(2, votoIn);
                st.setInt(3, codEventoIn);
                st.setString(4, usernameIn);
                st.executeUpdate();
        %>

        <br>
        <h2>Pubblicazione del commento andata a buon fine!</h2>
        <form action="index.html">
            <tr><td colspan="2"><input type="submit" value="Torna alla home"/></td>
        </form>

        <% } catch (SQLException ex) {
                out.println(ex);
            } catch (ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
                out.println(ex);
            }
        %>

    </body>
</html>
