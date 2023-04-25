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
    <link rel="stylesheet" href="../CSS/registro.css">
    <title>REGISTRO DE USUARIOS</title>
</head>

<body>
    <sql:query var="result" scope="request" dataSource="${usuarios}">
        select * from usuarios
    </sql:query>
    <div class="caja-todo">
        <div class=caja-intermedia>
            <div class="caja-titulo">
                <h1>SISTEMA UNIVERSITARIO</h1>
                <h1 class="titulo-pagina">AGREGAR USUARIO</h1>
            </div>
            <div class="caja-delantera">
                <c:if test="${param.cedula==null && param.nombre==null && param.cargo==null && param.contra==null}">
                    <form method="post">

                        <input type="text" name="cedula" id="cedula" placeholder="CEDULA"><br>
                        <input type="text" name="nombre" id="nombre" placeholder="NOMBRE"><br>
                        <input type="text" name="apellido" id="apellido" placeholder="APELLIDO"><br>

                        <select id="cargo" name="cargo">
                            <option value="administrador"></option>
                            <option value="coordinador">coordinador</option>
                            <option value="director">director</option>
                            <option value="evaluador">evaluador</option>
                            <option value="estudiante">estudiante</option>
                        </select><br>
                        <input type="text" name="contra" id="contra" placeholder="CONTRASEÑA"><br>

                        <button type="submit">REGISTRAR</button>
                    </form>
                </c:if>
                <c:if test="${param.cedula!=null && param.nombre!=null && param.cargo!=null}">
                    <sql:update var="result" dataSource="${usuarios}">
                        insert into usuarios (cedula,nombre,apellido,cargo,password)
                        values('${param.cedula}','${param.nombre}','${param.apellido}','${param.cargo}','${param.contra}')
                    </sql:update>
                    <c:if test="${result == 1}">
                        <h1 class="caja-titulo2">REgistro exitoso</h1>
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