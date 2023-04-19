<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../CSS/eliminarProfesor.css">
    <title>ELIMINAR USUARIO</title>
</head>
<body>
    <div class="caja-todo">
        <div class="caja-intermedia">
            <div class="caja-titulo">
            <h1>SISTEMA UNIVERSITARIO</h1>
            <h1 class="titulo-pagina">ElIMINAR USUARIO</h1>
            </div>
            <div class="caja-delantera">
                <c:if test="${param.id!=null}">
                    <sql:update var="result" dataSource="${usuarios}">
                        delete from usuarios where cedula=${param.id}
                    </sql:update>
                    <c:if test="${result == 1}">
                        <h1 class="caja-titulo2">usuario eliminado correctamente</h1>
                        <sql:query var="taller" dataSource="${usuarios}"> 
                    select * from usuarios where cedula="1005259101"
                    </sql:query>
                     <form method="post" action="principal.jsp">
                        <c:forEach var="itema" items="${taller.rows}">
                             <input type="text" id="usuario" name="usuario" value="${itema.cedula}" hidden>
                             <input type="text" id="contrasena" name="contrasena" value="${itema.password}" hidden>
                             <input type="text" id="cargo" name="cargo" value="${itema.cargo}" hidden>
                        </c:forEach>
                         <br>
                        <button type="submit">
                             <span>REGRESAR</span> 
                         </button>
                    </form>
                    </c:if>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>