<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="aplicacion.modelo.ejb.CrackabilidadEJB"%>
<%@ page import="aplicacion.modelo.ejb.PasswordsComunesEJB"%>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<html>
<head>
<title>Propaganda anti-hacker</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
	<h1>¡No quieres saber de lo que son capaces!</h1>
	<h3>
		¡Una contraseña <span class="importante">fácil de recordar</span> es
		una contraseña <span class="importante">fácil de robar</span>!
	</h3>
	<img src="imgs/Hack.jpg" alt="imgHacker">
	<form method="POST" action="Index.jsp">
		<div>
			<div id="izquierda">
				<p>¿Es segura tu contraseña?</p>
				<input type="password" name="password" id="password" placeholder="Escribe la contraseña">
			</div>
			<div id="derecha">
				<p>Pon a prueba sus 'ganzúas'</p>
				<input type="radio" name="procesador" value="cpu" checked="">CPU
				<input type="radio" name="procesador" value="gpu">GPU
				<input type="radio" name="procesador" value="grid">Grid
			</div>
		</div>
		<input type="submit" value="CALCULA" id="boton">
	</form>
	<div id="resultado">
		<%!
			CrackabilidadEJB calc;
			PasswordsComunesEJB comunes;
		%>
		<%
			String password = request.getParameter("password");
			String procesador = request.getParameter("procesador");
			if(password != null & procesador != null){
				Context context = null;
				try{
					context = new InitialContext();
					/*Declara las variables de los EJB*/
					calc = (CrackabilidadEJB) context.lookup("java:global/Actividad3.2/CrackabilidadEJB");
					comunes = (PasswordsComunesEJB) context.lookup("java:global/Actividad3.2/PasswordsComunesEJB");
				} catch(Exception e){
					e.printStackTrace();
				}
				if(comunes.esComun(password)){
					/*Si es una contraseña común redirige a otra página web*/
					response.sendRedirect("https://edition.cnn.com/2019/04/22/uk/most-common-passwords-scli-gbr-intl/index.html");
				} else{
					/*Si no, muestra el resultado del cálculo*/
					out.println(calc.calcularTiempo(password,procesador));
				}
			}
		%>
	</div>
	<footer id="pie">
		<h2>
			¡Comprueba <span class="importante">tu contraseña</span> antes de que
			sea DEMASIADO TARDE!
		</h2>
	</footer>
</body>
</html>