<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="repository.UsuarioRepository"%>
<%@page import="model.Usuario"%>
<%@page
	import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Funcionarios</title>
<!-- Boostrap CSS only -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
	crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">

			<div class="col">
				<h1 class="h1">Lista de Usuarios</h1>
				<button type="button" class="btn btn-sm mb-1 btn-secondary"
					onclick="window.location.href='cadastro.jsp'">Cadastrar
					Usuario</button>
				<button type="button" class="btn btn-sm mb-1 btn-danger"
					id="btnSair">Sair</button>

			</div>
			<div class="col-12 mt-1">
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">Código</th>
							<th scope="col">Nome</th>
							<th scope="col">Email</th>
							<th scope="col">Senha</th>
							<th scope="col">Telefones</th>
							<th scope="col"></th>
						</tr>
					</thead>
					<tbody>
					<%
						List<Usuario> usuarios = new UsuarioRepository().getAll();
						pageContext.setAttribute("usuarios", usuarios);
				        try {
							Usuario usuario = new UsuarioRepository().get(Long.parseLong(request.getParameter("id")));
							pageContext.setAttribute("usuario", usuario);
						} catch (Exception e) {
							response.sendRedirect("index.jsp");
						}

					%>
						<c:forEach var="us" items="${usuarios}">
							<c:choose>
								<c:when test="${usuario.id == us.id}">
									<tr>
										<th scope="row"><c:out value="${us.id}"></c:out></th>
										<td><c:out value="${us.nome}"></c:out></td>
										<td><c:out value="${us.email}"></c:out></td>
										<td><c:out value="${us.senha}"></c:out></td>
										<td><c:forEach var="t" items="${us.telefones}">
												<c:out value="${t.ddd}${t.numero}"></c:out>
												<br>
											</c:forEach></td>
										<td>
											<button type="button" class="btn btn-primary"  onclick="window.location.href='cadastro.jsp?id=${us.id}'">Atualizar</button>
											<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">Deletar</button>
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<th scope="row"><c:out value="***"></c:out></th>
										<td><c:out value="${us.nome}"></c:out></td>
										<td><c:out value="${us.email}"></c:out></td>
										<td><c:out value="**********"></c:out></td>
										<td><c:forEach var="t" items="${us.telefones}">
												<c:out value="${t.ddd}${t.numero}"></c:out>
												<br>
											</c:forEach></td>
										<td>
											<button type="button" disabled class="btn btn-primary">Atualizar</button>
											<button type="button" disabled class="btn btn-danger">Deletar</button>
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="modal fade" id="deleteModal" tabindex="-1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Atenção!</h5>
		      </div>
		      <div class="modal-body">
		        Você reamente deseja deletar o seu Usuario?
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Não</button>
		        <button type="button" id="btdDelete" class="btn btn-danger">Sim</button>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
	<!-- Container -->
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8" crossorigin="anonymous"></script>
	<script type="text/javascript">		
		var usuario;
		window.onload = function(){
			if (sessionStorage.getItem('usuario')) {
		        usuario = JSON.parse(sessionStorage.getItem('usuario'));
		    } else {
		        window.location.href = 'index.jsp';
		    }
		}
		
		var btnSair = document.getElementById('btnSair');
		var btdDelete = document.getElementById('btdDelete');
		
		btnSair.addEventListener('click', function(){
			sessionStorage.removeItem('usuario');
			window.location.href = 'index.jsp';
		});
		
		btdDelete.addEventListener('click', function(){
		    var xhttp = new XMLHttpRequest();
		    xhttp.onreadystatechange = function () {
		        if (this.readyState == 4 && this.status == 200) {
		        	btnSair.click();
		        }
		    }
		    
		    
		   xhttp.open("DELETE", "usuario?id="+usuario.id, true);
		   xhttp.setRequestHeader("Content-type", "application/json");
		   xhttp.send(JSON.stringify(usuario));
		});
	</script>
</body>
</html>