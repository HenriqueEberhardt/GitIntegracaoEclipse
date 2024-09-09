<%-- 
    Document   : adicionarProduto
    Created on : 9 de set. de 2024, 09:33:43
    Author     : henrique_eberhardt
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Date" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="3; url=gestao.html"> <!-- Redirecionar após 3 segundos -->
        <title>Adicionar Produto</title>
    </head>
    <body>
        <%
            // Definição de variáveis para capturar os dados do formulário
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

                // Converter a string de data para java.sql.Date
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedDate = format.parse(dataInspecaoStr);
                dataInspecao = new java.sql.Date(parsedDate.getTime());

                // Fazer a conexão com o banco de dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco303", "root", "");

                // Inserir os dados na tabela produto do banco de dados
                st = conecta.prepareStatement("INSERT INTO produto (Id_Produto, Nome_Produto, Descr_Produto, Data_Fabric, Quali_Produto) VALUES (?, ?, ?, ?, ?)");
                st.setInt(1, idproduto);
                st.setString(2, nome);
                st.setString(3, descricao);
                st.setFloat(4, qualidadeproduto);
                st.setDate(5, dataInspecao);

                st.executeUpdate(); // Executa o comando INSERT
                out.println("<h2>Produto adicionado com sucesso!</h2>");
                
                // Fechar a conexão
                st.close();
                conecta.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h2>Erro ao adicionar o produto: " + e.getMessage() + "</h2>");
            }
        %>
        <script>
            // Função opcional para redirecionar ou atualizar a página
            function atualizarPagina() {
                window.location.href = "gestao.html"; // Redirecionar de volta para a página de gestão
            }
        </script>
    </body>
</html>
