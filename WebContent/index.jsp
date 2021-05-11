<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Sign In</title>
	<!-- Boostrap CSS only -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
				
			<div class="col-7 mt-5">
				<h1 class="mb-2">Sign In</h1>
				
				<form id="formLogin">
					<div class="form-group mt-5">
						<label>Email</label>
						<input type="email" required="required" class="form-control" name="email">
					</div>
					<div class="form-group mb-1">
						<label>Senha</label>
						<input type="password" required="required" class="form-control" name="senha">
						<a href="cadastro.jsp" class="link-primary">Criar Conta</a>		
					</div>
					 
					<button type="submit" class="btn btn-primary mt-3">Entrar</button>
				</form>
			</div>
			
		</div>
	</div>
	<script type="text/javascript">
		var formLogin = document.getElementById('formLogin');
		
		formLogin.addEventListener("submit",function(e){
		    e.preventDefault();
		    
		    var usuarioLogin = {
		        'email': document.getElementsByName('email')[0].value,
		        'senha': document.getElementsByName('senha')[0].value
		    }
		    
		    //console.log(usuarioLogin);
		    
		    var xhttp = new XMLHttpRequest();
		    xhttp.onreadystatechange = function () {
		        if (this.readyState == 4 && this.status == 200) {
		            var obj = JSON.parse(this.responseText);
					console.log(obj);
					formLogin.reset();
					verificaResposta(obj)
		        }
		    }
		    
		    
		    xhttp.open("POST", "usuario?signin=true", true);
		    xhttp.setRequestHeader("Content-type", "application/json");
		    xhttp.send(JSON.stringify(usuarioLogin));
			
		});
		
		function verificaResposta(usuario){
			if (usuario.id === 0) {
				alert("Email ou Senha Incorretos.");
			}
			else if (usuario.id === undefined){
				alert("Informções de Login invalidas.");
			}
			else {
				sessionStorage.setItem('usuario', JSON.stringify(usuario));
				window.location.href = 'listagem.jsp?id='+usuario.id;
			}
		}
	</script>
</body>
</html>