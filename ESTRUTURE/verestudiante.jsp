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
    <link rel="stylesheet" href="../CSS/ver_estudiante.css">
    <title>VER PROYECTO Y ESTADO</title>
</head>

<body>
    <div class="caja-todo">
        <div class="caja">
        <form method="post">
                <c:if test="${param.pro==null}">
                        <sql:query var="taller" dataSource="${usuarios}">
                            select * from general where estudiante=?
                        <sql:param value="${param.id}">
                            </sql:param>
                        </sql:query>
                            <c:forEach var="item" items="${taller.rows}" >
                                <h1>SUBIENDO PROYECTO DEL ESTUDIANTE
                                </h1>
                                <input type="text" id="pro" name="pro" value="${item.proyecto}">
                                <c:set var="come" value="${item.proyecto}" />
                                <button type="submit">Enviar</button>
                            </c:forEach>
                </c:if>
        </form>
        <c:if test="${param.pro!=null}">
            <c:if test="${param.pro!=come}">
                <sql:update var="result3" dataSource="${usuarios}">
                    update general set proyecto='${param.pro}' where estudiante="${param.id}"
                </sql:update>
                <h1>Proyecto subido correctamente</h1>
            </c:if>

            <c:if test="${param.pro==come}">
                <h1 >fallo al subirlo vuelva a ingresar</h1>
            </c:if>
        </c:if>
        <sql:query var="taller2" dataSource="${usuarios}">
            select * from usuarios where cedula="${param.id}"
        </sql:query>
            <form method="post" action="principal.jsp">
                <c:forEach var="itema2" items="${taller2.rows}">
                    <input type="hidden" id="usuario" name="usuario" value="${itema2.cedula}">
                    <input type="hidden" id="contrasena" name="contrasena" value="${itema2.password}">
                    <input type="hidden" id="cargo" name="cargo" value="${itema2.cargo}">
                </c:forEach>
                <br>
                <button type="submit">
                    <span>REGRESAR</span>
                </button>
            </form>
        <div>
    </div>
</body>

</html>