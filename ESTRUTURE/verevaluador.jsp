<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>PRINCIPAL</title>
    <link rel="stylesheet" href="../CSS/verevaluador.css">
</head>

<body>
<sql:query var="result" dataSource="${usuarios}">
                select * from general
                where estudiante=?
                <sql:param value="${param.estu}">
                </sql:param>
            </sql:query>
            <sql:query var="result2" dataSource="${usuarios}">
                select * from usuarios
                where cedula=?
                <sql:param value="${param.cedu}">
                </sql:param>
            </sql:query>
    <div class="caja-todo">
    <h1>ESTADO DE PROYECTO DEL ESTUDIANTE</h1>
        <div class="caja">
            
            <c:if test="${param.modificar==null}">
                <form method="post">
                    <select name="est_evaluador" id="est_evaluador">
                        <option value="aprobado">aprobado</option>
                        <option value="desaprobado">no aprobado</option>
                    </select>
                    <c:forEach var="itema2" items="${result.rows}">
                        <input type="hidden" name="modificar2" id="modificar2" value="${itema2.estudiante}">
                    </c:forEach><br>
                    <c:forEach var="itema" items="${result2.rows}">
                        <input type="hidden" name="modificar" id="modificar" value="${itema.cedula}">
                    </c:forEach>
                    <button type="submit">cambiar</button>
                </form>
            </c:if>
            <c:if test="${param.modificar!=null}">
                <sql:update var="result" dataSource="${usuarios}">
                    update general set estado_evaluador="${param.est_evaluador}"
                    where estudiante='${param.modificar2}'
                </sql:update>
                <h1>ESTADO DE PROYECTO CAMBIADO</h1>
                <sql:query var="taller" dataSource="${usuarios}">
                    select * from usuarios where cedula=?
                    <sql:param value="${param.modificar}">
                    </sql:param>
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
</body>

</html>