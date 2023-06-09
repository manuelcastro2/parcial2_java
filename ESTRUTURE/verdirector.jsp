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
    <link rel="stylesheet" href="../CSS/verdirector.css">
</head>

<body>
    <!--DIV QUE ENCIERRA TODO-->
    <div class="caja-todo">
        <!--DIV QUE ENCIERRA EL CONTENIDO PERO NO SE MUESTRA EN TODA LA PANTALLA-->
        <div class="caja">
            <!--SQL PARA LLAMAR LOS DATOS DEL ESTUDIANTE-->
            <sql:query var="result" dataSource="${usuarios}">
                select * from general
                where estudiante=?
                <sql:param value="${param.id}">
                </sql:param>
            </sql:query>
            <!--CONDICIONAL PARA SI ESTA VACIO ENTRE-->
            <c:if test="${param.modificar==null}">
                <form method="post">
                    <!--FOREACH PARA MOSTRAR LOS DATOS -->
                    <c:forEach var="itema" items="${result.rows}">
                        <h1>ESTADO DEL PROYECTO DEL ESTUDIANTE - CEDULA:${itema.estudiante}</h1>
                        <select name="est_coordinador" id="est_coordinador">
                            <option value="aprobado">aprobado</option>
                            <option value="desaprobado">no aprobado</option>
                        </select>
                        <input type="hidden" name="modificar" id="modificar" value="${itema.agregar_director}"><br>
                        <button type="submit">cambiar</button>
                    </c:forEach>
                </form>
            </c:if>
            <!--CONDICIONAL SI NO ESTA VACIO MUESTRE ESTO-->
            <c:if test="${param.modificar!=null}">
                <!--SQL UPDATE PARA ACTUALIZAR EL ESTADO-->
                <sql:update var="result" dataSource="${usuarios}">
                    update general set estado_director="${param.est_coordinador}"
                    where estudiante='${param.id}'
                </sql:update>
                <h1>ESTADO DE PROYECTO CAMBIADO</h1>
                <!--CONSULTA PARA VOLVER A LA PAGINA PRINCIPAL-->
                <sql:query var="taller" dataSource="${usuarios}">
                    select * from usuarios where cedula=?
                    <sql:param value="${param.modificar}">
                    </sql:param>
                </sql:query>
                <!--ATRAER LA INFORMACION PARA ENVIARLA-->
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