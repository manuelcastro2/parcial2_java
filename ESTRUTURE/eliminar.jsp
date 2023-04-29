<!--AGREGO LAS LIBRERIAS-->
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
    <!--LINK DEL CSS-->
    <link rel="stylesheet" href="../CSS/eliminar.css">
    <title>ELIMINAR USUARIO</title>
</head>

<body>
<!--CAJA QUE ENCIERRO TODO-->
    <div class="caja-todo">
    <!--CAJA QUE ENCIERRA TODO EL CONTENIDO PERO NO SE MUESTRA EN TODA LA PANTALLA-->
        <div class="caja-intermedia">
        <!--CAJA QUE ENCIERRA EL TITULO-->
            <div class="caja-titulo">
                <h1>SISTEMA UNIVERSITARIO</h1>
                <h1 class="titulo-pagina">ElIMINAR USUARIO</h1>
            </div>
        <!--CAJA QUE ENCIERRA SOLAMENTE EL CONTENIDO-->
            <div class="caja-delantera">
            <!--CONDICION SI UN ELEMENTO ESTA VACIO NO DEJE INGRESAR-->
                <c:if test="${param.id!=null}">
                <!--HAGO UN DELETE DEL USUARIO SELECIONADO-->
                    <sql:update var="result" dataSource="${usuarios}">
                        delete from usuarios where cedula=${param.id}
                    </sql:update>
                    <!--CONDICION SI SE EFECTUA SI EL DELETE OPERO CORRECTAMENTE-->
                    <c:if test="${result == 1}">
                    <!--MUESTRO ESTE H1-->
                        <h1 class="caja-titulo2">usuario eliminado correctamente</h1>
                        <!--HAGO UNA CONSULTA PARA QUE EL ADMINISTRADO PUEDA VOLVER A INGRESAR A LA PAGINA PRINCIPAL-->
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
                            <button class="button" type="submit">
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