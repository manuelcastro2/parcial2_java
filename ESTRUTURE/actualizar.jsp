<!--AGREGO LAS LIBRERIAS DEL JSTL-->
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
    <link rel="stylesheet" href="../CSS/actualizar.css">
    <title>ACTUALIZAR</title>
</head>

<body>
    <!--CAJA QUE ENCIERRA TOOD Y OCUPA TODO EL BODY-->
    <div class="caja-todo">
        <!--CAJA QUE ENCIERRA EL CONTENIDO PERO NO OCUPA TODA LA PANTALLA-->
        <div class="caja-intermedia">
            <!--CAJA DEL TAMAÑO DEL TITULO-->
            <div class="caja-titulo">
                <h1>SISTEMA UNIVERSITARIO</h1>
                <h1 class="titulo-pagina">ACTUALIZAR USUARIO</h1>
            </div>
            <!--CAJA QUE LE DA UN TAMAÑO MAXIMO DEL CONTENIDO-->
            <div class="caja-delantera">
                <!--CONDICION SI EL PARAMETRO ESTA VACIO MUESTRE LOS DATOS-->
                <c:if test="${param.modificar ==null}">
                    <!--CONSULTA SQL DE LA TABLA USUARIOS-->
                    <sql:query var="taller" dataSource="${usuarios}">
                        select * from usuarios where cedula=?
                        <sql:param value="${param.id}">
                        </sql:param>
                    </sql:query>
                    <!--FORM SIN DIRECCIONAMIENTO-->
                    <form method="post">
                        <!--FOREACH DE LAS COLUMNAS QUE ENCONTRO LA CONSULTA-->
                        <c:forEach var="itema" items="${taller.rows}">
                            <!--LLAMO LA CEDULA Y LA AGREGO AL INPUT-->
                            <input type="text" name="usuario" id="usuario" value="${itema.cedula}">
                            <br>
                            <!--LLAMO LA NOMBRE Y LA AGREGO AL INPUT-->
                            <input type="text" name="nombre" id="nombre" value="${itema.nombre}">
                            <br>
                            <!--LLAMO LA APELLIDO Y LA AGREGO AL INPUT-->
                            <input type="text" name="apellido" id="apellido" value="${itema.apellido}">
                            <br>
                            <!--LLAMOEL CARGO Y LA AGREGO AL SELECT-->
                            <select id="cargo" name="cargo">
                                <option value="${itema.cargo}">
                                    <c:out value="${itema.cargo}" /> <-dato antiguo</option>
                                <option value="coordinador">coordinador</option>
                                <option value="director">director</option>
                                <option value="evaluador">evaluador</option>
                                <option value="estudiante">estudiante</option>
                            </select>
                            <br>
                            <!--LLAMO LA CONTRASEÑA Y LA AGREGO AL INPUT-->
                            <input type="text" name="contrasena" id="contrasena" value="${itema.password}">
                            <br>
                        </c:forEach>
                        <!--INPUT DE INTERACCION ENTRE LA CODICIONES DE MUESTREO DE CONTENIDO EN LA PANTALLA-->
                        <input type="hidden" name="modificar" id="modificar" value="si">
                        <!--ENVIO LOS DATOS-->
                        <button type="submit">ENVIAR</button>
                    </form>

                </c:if>
                <!--CODICION SI ESA VARIABLE YA NO ESTA VACIA ENTRE-->
                <c:if test="${param.modificar !=null}">
                    <!--COLOCO LA INFORMACION QUE RECOGI DEL FORM Y LE HAGO UN UPDATE A LA BASE DE DATOS-->
                    <sql:update var="result" dataSource="${usuarios}">
                        update usuarios
                        set cedula='${param.usuario}', nombre='${param.nombre}',
                        apellido='${param.apellido}',cargo='${param.cargo}', password='${param.contrasena}'
                        where cedula='${param.id}'
                    </sql:update>
                    <!--MUESTRO ESTE H1-->
                    <h1 class="caja-titulo2">Datos actualizados correctamente</h1>
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