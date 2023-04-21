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
    <link rel="stylesheet" href="../CSS/principal.css">
</head>
<body>

    <c:if test="${empty param.usuario or empty param.contrasena or empty param.cargo}">
        <p>Por favor ingrese su nombre de usuario, contraseña y selecione su cargo</p>
        <a href="../index.html">Regresar</a>
    </c:if>

    <c:if test="${not empty param.usuario and not empty param.contrasena and not empty param.cargo}">

        <sql:query dataSource="${usuarios}" var="resultado" sql="SELECT * FROM usuarios WHERE cedula = ? AND password = ? AND cargo = ?">
            <sql:param value="${param.usuario}" />
            <sql:param value="${param.contrasena}" />
            <sql:param value="${param.cargo}" />
        </sql:query>

        <c:if test="${resultado.rowCount eq 1}">
            <h2>Bienvenido, ${resultado.rows[0].nombre}!</h2>

            <c:if test="${resultado.rows[0].cargo =='administrador'}">

            <sql:query var="result" scope="request" dataSource="${usuarios}">
        select * from usuarios
    </sql:query>

    <div class="caja-todo">
        <div class="caja-intermedia">
            <div class="caja-titulo">
            <h1>DATOS USUARIOS</h1>
            </div>
            <div class="caja-delantera">
            <a href="registro.jsp" data-text="Awesome" class="button">
            <span class="actual-text">&nbsp;AGREGAR PROFESOR&nbsp;</span>
    <span class="hover-text" aria-hidden="true">&nbsp;AGREGAR PROFESOR&nbsp;</span>
            </a>
              <div>
                  <table class="item tres">
                    <thead>
                        <tr>
                            <th> cedula</th>
                            <th>nombre</th>
                            <th>apellido</th>
                            <th>cargo</th>
                            <th>contraseña</th>
                            <th colspan="2">acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="fila" items="${result.rows}">
                        <tr>
                        <td><c:out value="${fila.cedula}"/></td>
                        <td><c:out value="${fila.nombre}"/></td>
                        <td><c:out value="${fila.apellido}"/></td>
                        <td><c:out value="${fila.cargo}"/></td>
                        <td><c:out value="${fila.password}"/></td>
                        <td><a class="button2" href="eliminar.jsp?id=${fila.cedula}">Eliminar</a></td>
                        <td><a class="button2" href="actualizar.jsp?id=${fila.cedula}">Editar</a></td>
                        </c:forEach>
                        </tr>
                    </tbody>
                </table>
                <a href="../index.html">cerrar</a>
              </div>
            </div>
        </div>
    </div>
            </c:if>
        <c:if test="${resultado.rows[0].cargo =='coordinador'}">
            <a href="ver_proyectos.jsp">ver proyectos</a>
            <a href="#">consulta calendario academico</a>
            <a href="#">consultar formato de grado</a>
        </c:if>
        <c:if test="${resultado.rows[0].cargo =='estudiante'}">
                                <sql:query var="result" dataSource="${usuarios}">
                                    select * from general,usuarios
                                    where cargo="estudiante" and estudiante=?
                                    <sql:param value="${param.usuario}">
                                    </sql:param>
                                </sql:query>
                                <c:forEach var="itema" items="${result.rows}">
                                <c:if test="${itema.estado_coordinador=='aprobado'}">
                                <a href="verestudiante.jsp?id=${itema.estudiante}">subir proyecto y ver estado de avance</a>
                                </c:if>
                                </c:forEach>
                                <table border="1">
                                    <thead> 
                                    <td>
                                        pre-proyecto
                                    </td>
                                    <td>
                                        proyecto
                                    <td colspan="2">
                                        estudiante
                                    </td>
                                    <td colspan="2">
                                        director
                                    </td>
                                    <td>estado coordinacion</td>
                                    <td>estado director</td>
                                    <td>estado evaluador</td>
                                    </thead>
                                    <c:forEach var="itema" items="${result.rows}">
                                        <tr>
                                            <td>
                                                <c:out value="${itema.pre_proyecto}" />
                                            </td>
                                            <td>
                                            <c:if test="${itema.estado_coordinador=='revision'}">
                                               <c:out value="${'aun no se puede subir proyecto'}" />
                                                </c:if>
                                            <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto==''}">
                                            <c:out value="${'ya se puede subir'}" />
                                            </c:if>
                                            <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto!=''}">
                                            <c:out value="${itema.proyecto}" />
                                            </c:if>
                                            </td>
                                            <td>
                                                <c:out value="${itema.estudiante}" />
                                            </td>
                                            <td>
                                                <c:out value="${itema.nombre} ${itema.apellido}" />
                                            </td>
                                            <td>
                                                <c:out value="${itema.agregar_director}" />
                                                <sql:query var="result2" dataSource="${usuarios}">
                                            select * from usuarios
                                            where  cedula='${itema.agregar_director}'
                                             </sql:query>
                                            </td>
                                            </c:forEach>
                                            <c:forEach var="itema2" items="${result2.rows}">
                                            <td>
                                                <c:out value="${itema2.nombre} ${itema2.apellido}" />
                                            </td>
                                            </c:forEach>
                                            <c:forEach var="itema" items="${result.rows}">
                                            <td>
                                                <c:out value="${itema.estado_coordinador}" />
                                            </td>
                                            <td>
                                            <c:if test="${itema.estado_coordinador=='aprobado' && itema.estado_director!=''}">
                                                <c:out value="${itema.estado_director}" />
                                                 </c:if>
                                                 <c:if test="${itema.estado_coordinador=='aprobado' && itema.estado_director==''}">
                                                <c:out value="${'No revisado'}" />
                                                 </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${itema.estado_coordinador=='aprobado' && itema.estado_director!=''}">
                                                <c:out value="${itema.estado_evaluador}" />
                                                 </c:if>
                                                 <c:if test="${itema.estado_coordinador=='aprobado' && itema.estado_director==''}">
                                                <c:out value="${'No revisado'}" />
                                                 </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            
           <a href="#">consulta calendario academico</a>
            <a href="#">consultar formato de grado</a>
            <a href="../index.html">cerrar sesion</a>
        </c:if>
            
        </c:if>
        <c:if test="${resultado.rowCount eq 0}">
            <p>Usuario, password o cargo incorrectos. Por favor, intente de nuevo.</p>
            <a href="../index.html">Regresar</a>
        </c:if>
         </c:if>
           
</body>
</html>