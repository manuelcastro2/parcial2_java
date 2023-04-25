<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../CSS/actualizar.css">
    <title>ACTUALIZAR</title>
</head>

<body id="body">
    <div class="caja-todo">
        <div class="caja-intermedia">
            <div class="caja-titulo">
                <h1>SISTEMA UNIVERSITARIO</h1>
                <h1 class="titulo-pagina">ACTUALIZAR USUARIO</h1>
            </div>
            <div class="caja-delantera">
                <c:if test="${param.modificar ==null}">
                    <sql:query var="taller" dataSource="${usuarios}">
                        select * from usuarios where cedula=?
                        <sql:param value="${param.id}">
                        </sql:param>
                    </sql:query>
                    <form method="post">
                        <c:forEach var="itema" items="${taller.rows}">
                            <input type="text" name="usuario" id="usuario" value="${itema.cedula}">
                            <br>
                            <input type="text" name="nombre" id="nombre" value="${itema.nombre}">
                            <br>
                            <input type="text" name="apellido" id="apellido" value="${itema.apellido}">
                            <br>
                            <select id="cargo" name="cargo">
                                <option value="${itema.cargo}">
                                    <c:out value="${itema.cargo}" /> <-dato antiguo</option>
                                <option value="coordinador">coordinador</option>
                                <option value="director">director</option>
                                <option value="evaluador">evaluador</option>
                                <option value="estudiante">estudiante</option>
                            </select>
                            <br>
                            <input type="text" name="contrasena" id="contrasena" value="${itema.password}">
                            <br>
                        </c:forEach>
                        <input type="hidden" name="modificar" id="modificar" value="si">
                        <button type="submit">ENVIAR</button>
                    </form>

                </c:if>
                <c:if test="${param.modificar !=null}">
                    <sql:update var="result" dataSource="${usuarios}">
                        update usuarios
                        set cedula='${param.usuario}', nombre='${param.nombre}',
                        apellido='${param.apellido}',cargo='${param.cargo}', password='${param.contrasena}'
                        where cedula='${param.id}'
                    </sql:update>
                    <h1 class="caja-titulo2">Datos actualizados correctamente</h1>
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
            </div>
        </div>
    </div>
</body>

</html>