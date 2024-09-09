<%-- 
    Document   : atualizarProduto
    Created on : 9 de set. de 2024, 09:25:39
    Author     : henrique_eberhardt
--%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%
    String nome;
    String descricao;
    float qualidadeproduto;
    int idproduto;
    String dataInspecaoStr;
    java.sql.Date dataInspecao = null;

    try {
        // Recuperar os parâmetros do formulário
        idproduto = Integer.parseInt(request.getParameter("codigo-produto"));
        nome = request.getParameter("nome-produto");
        descricao = request.getParameter("descricao-produto");
        qualidadeproduto = Float.parseFloat(request.getParameter("qualidade-produto"));
        dataInspecaoStr = request.getParameter("data-de-inspecao-produto");

        // Converter a string de data em java.sql.Date
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date parsedDate = format.parse(dataInspecaoStr);
        dataInspecao = new java.sql.Date(parsedDate.getTime());

        // Fazer conexão com o banco de dados
        Connection conecta;
        PreparedStatement st;
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco303", "root", "senha_do_mysql");

        // Inserir os dados na tabela produto do banco de dados
        st = conecta.prepareStatement("INSERT INTO produto (Id_Produto, Nome_Produto, Descr_Produto, Quali_Produto, Data_Fabric) VALUES (?, ?, ?, ?, ?)");
        st.setInt(1, idproduto);
        st.setString(2, nome);
        st.setString(3, descricao);
        st.setFloat(4, qualidadeproduto);
        st.setDate(5, dataInspecao);

        st.executeUpdate(); // Executa o comando insert
        out.println("<p>Produto adicionado com sucesso!</p>");
        // Fechar a conexão
        st.close();
        conecta.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Erro ao adicionar o produto: " + e.getMessage() + "</p>");
    }
%>

        <h1>Hello World!</h1>
    </body>
</html>
