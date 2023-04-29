<!--LIBRERIAS DE JSTL-->
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
    <!--LINK DE CSS-->
    <link rel="stylesheet" href="../CSS/verevaluador.css">
</head>

<body>
    <!--CONSULTA LA INFO DEL ESTUDIANTE-->
    <sql:query var="result" dataSource="${usuarios}">
        select * from general
        where estudiante=?
        <sql:param value="${param.estu}">
        </sql:param>
    </sql:query>
    <!--CONSULTA LA INFO DEL EVALUADOR-->
    <sql:query var="result2" dataSource="${usuarios}">
        select * from usuarios
        where cedula=?
        <sql:param value="${param.cedu}">
        </sql:param>
    </sql:query>
    <!--DIV QUE ENCIERRA TODO-->
    <div class="caja-todo">
        <h1>ESTADO DE PROYECTO DEL ESTUDIANTE</h1>
        <!--DIV QUE ENCIERRA EL CONTENIDO PERO NO SE MUESTRA EN TODA LA PANTALLA-->
        <div class="caja">
            <!--CONDICIONAL SI EL VALOR ESTA VACIO ENTRE-->
            <c:if test="${param.modificar==null}">
                <!--RECOGIMIENTO DE DATOS Y ENVIO DE DATOS-->
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
            <!--CONDICIONAL SI EL VALOR ES DIFERENTE A VACIO-->
            <c:if test="${param.modificar!=null}">
                <!--SQL DE ACTUALIZACION DE DATOS-->
                <sql:update var="result" dataSource="${usuarios}">
                    update general set estado_evaluador="${param.est_evaluador}"
                    where estudiante='${param.modificar2}'
                </sql:update>
                <h1>ESTADO DE PROYECTO CAMBIADO</h1>
                <!--CONSULTA DE DATOS PARA VOLVER A LA PAGINA PRINCIPAL-->
                <sql:query var="taller" dataSource="${usuarios}">
                    select * from usuarios where cedula=?
                    <sql:param value="${param.modificar}">
                    </sql:param>
                </sql:query>
                <!--RECIBIENTO DE DATOS Y ENVIO-->
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