<%@page import="repository.UsuarioRepository"%>
<%@page import="model.Usuario"%>
<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Cadastro</title>
	<!-- Boostrap CSS only -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<%
				Long codigo = 0l;
				Usuario u = null;
				String cod = request.getParameter("id");
				
				if (cod != null){
					try {
						
						codigo = Long.parseLong(cod);
						u = new UsuarioRepository().get(codigo);
						pageContext.setAttribute("usuario", u);
						
					}catch (Exception e) {
						response.sendRedirect("index.jsp");
					}
				}

				
				if (u == null){
					
			%>
			<div class="col-7 mt-5">
				<h1 class="mb-2">Cadastrar Usuario</h1>
				
				<form id="formCadastro">
					<div class="form-group mt-5">
						<label>Nome</label>
						<input type="text" required class="form-control" name="nome">		
					</div>
					<div class="form-group">
						<label>Email</label>
						<input type="email" required class="form-control" name="email">
					</div>
					<div class="form-group">
						<label>Senha</label>
						<input type="password" required class="form-control" name="senha">		
					</div>
					<div class="form-group mb-1" id="fones">
						<label>Telefones <small>(Apenas um Telefone é obrigatorio)</small></label>
          				<input type="text" class="form-control mb-2" placeholder="(00) 00000-0000" required id="telefone1" name="telefones" pattern="\([0-9]{2}\)[\s][0-9]{4,5}-[0-9]{4}" >
          				<input type="text" class="form-control mb-2" placeholder="(00) 00000-0000" id="telefone2" name="telefones" pattern="\([0-9]{2}\)[\s][0-9]{4,5}-[0-9]{4}" >
          				<input type="text" class="form-control mb-1" placeholder="(00) 00000-0000" id="telefone3" name="telefones" pattern="\([0-9]{2}\)[\s][0-9]{4,5}-[0-9]{4}" >
						<a href="index.jsp" class="link-primary">Fazer Login</a>
					</div>
					 
					<button type="submit" class="btn btn-primary mt-3">Criar</button>
				</form>
			</div>
			<%
				} else {
						
			%>
			<div class="col-7 mt-5">
				<h1 class="mb-2">Atualuzar Usuario</h1>
				
				<form id="formAtualizar">
					<div class="form-group mt-5">
						<label>Nome</label>
						<input type="text" required class="form-control" name="attNome" value="${usuario.nome}">		
					</div>
					<div class="form-group">
						<label>Email</label>
						<input type="email" required class="form-control" name="attEmail" value="${usuario.email}">
					</div>
					<div class="form-group">
						<label>Senha</label>
						<input type="password" required class="form-control" name="attSenha" value="${usuario.senha}">		
					</div>
					<div class="form-group mb-1" id="fones">
						<label>Telefones <small>(Apenas um Telefone é obrigatorio)</small></label>
						<c:forEach var="t" items="${usuario.telefones}">
							<input type="text" class="form-control telefone mb-2" placeholder="(00) 00000-0000" required name="attTelefones" pattern="\([0-9]{2}\)[\s][0-9]{4,5}-[0-9]{4}" value="${t.ddd}${t.numero}">
						</c:forEach>
						<a href="listagem.jsp?id=${usuario.id}" class="link-primary mt-2">Lista de Usuarios</a>
					</div>
					 
					<button type="submit" class="btn btn-primary mt-3">Atualizar</button>
				</form>
			</div>
			
			<%
				}
			%>
			
		</div>
	</div>
	<script type="text/javascript">	
		var usuario;
		window.onload = function(){
			var url = window.location.href;
			
			if (url.includes('id')) {
				if (sessionStorage.getItem('usuario')) {
			        usuario = JSON.parse(sessionStorage.getItem('usuario'));
			    } else {
			        window.location.href = 'index.jsp';
			    }
			}
		}
		
		$("#telefone1, #telefone2, #telefone3, .telefone").mask("(00) 90000-0000");

		var formCadastro = document.getElementById('formCadastro');
		
		var formAtualizar = document.getElementById('formAtualizar');
		
		if (formCadastro !== null) formCadastro.addEventListener("submit", formCadastroSubmit);
		
		if (formAtualizar !== null) formAtualizar.addEventListener("submit", formAtualizarSubmit);
		
		
		function formCadastroSubmit(e){
		    e.preventDefault();
		    
		    var fones =  document.getElementsByName('telefones');
		    
		    var telefoneObj = [];
		    
		    for (const f of fones) {
		    	var fone = f.value;
		    	fone = fone.replace("(", "");
			    fone = fone.replace(")", "");
			    fone = fone.replace("-", "");
			    fone = fone.replace(" ", "");
			    
			   	var ddd = fone.slice(0, 2);
			    var numero = fone.slice(2, fone.length);
			    if (fone !== "") {
				    var obj = {
				    		'ddd': Number(ddd),
				    		'numero': numero
				    	};	
				    
			    	console.log(obj);
			    	telefoneObj.push(obj);
				}

		    }
		    
		    console.log();
		    
		    var usuarioCadastro = {
		        'email': document.getElementsByName('email')[0].value,
		        'nome': document.getElementsByName('nome')[0].value,
		        'senha': document.getElementsByName('senha')[0].value,
		        'telefones': telefoneObj
		    }	
		    
		    //console.log(usuarioCadastro);
		    
		    var xhttp = new XMLHttpRequest();
		    xhttp.onreadystatechange = function () {
		        if (this.readyState == 4 && this.status == 200) {
		            var obj = JSON.parse(this.responseText);
					console.log(obj);
					verificaResposta(obj);
					formCadastro.reset();
					
		        }
		    }
		    
		    
		   xhttp.open("POST", "usuario?signup=true", true);
		   xhttp.setRequestHeader("Content-type", "application/json");
		   xhttp.send(JSON.stringify(usuarioCadastro));
			
		}
		
		function formAtualizarSubmit(e){
		    e.preventDefault();
		    
		    var fones =  document.getElementsByName('attTelefones');
		    
		    var telefoneObj = [];
		    
		    for (const f of fones) {
		    	var fone = f.value;
		    	fone = fone.replace("(", "");
			    fone = fone.replace(")", "");
			    fone = fone.replace("-", "");
			    fone = fone.replace(" ", "");
			    
			   	var ddd = fone.slice(0, 2);
			    var numero = fone.slice(2, fone.length);
			    if (fone !== "") {
				    var obj = {
				    		'ddd': Number(ddd),
				    		'numero': numero
				    	};	
				    
			    	console.log(obj);
			    	telefoneObj.push(obj);
				}

		    }
		    
		    console.log();
		    
			usuario.email = document.getElementsByName('attEmail')[0].value;
			usuario.nome = document.getElementsByName('attNome')[0].value;
			usuario.senha = document.getElementsByName('attSenha')[0].value;
			usuario.telefones = telefoneObj;

		    
		    //console.log(usuarioCadastro);
		    
		    var xhttp = new XMLHttpRequest();
		    xhttp.onreadystatechange = function () {
		        if (this.readyState == 4 && this.status == 200) {
		            var obj = JSON.parse(this.responseText);
					console.log(obj);
					if (obj.id === 0 || obj.id === undefined) {
						alert("Erro ao atualizar Usuario");
						return;
					}			
					alert("Usuario Alterado!");
					window.location.href = 'listagem.jsp?id='+usuario.id;	
		        }
		    }
		    
		    
		   xhttp.open("PUT", "usuario", true);
		   xhttp.setRequestHeader("Content-type", "application/json");
		   xhttp.send(JSON.stringify(usuario));
		}
		
		function verificaResposta(usuario){
			if (usuario.id === 0) {
				alert("Esse Email Ja está sendo Utilizado!");
			}
			else if (usuario.id === undefined){
				alert("Dados de Cadastros Invalidos");
			}
			else {
				alert("Usuario Cadastrado com sucesso!");
				window.location.href = 'index.jsp';
			}
		}
	</script>
</body>
</html>