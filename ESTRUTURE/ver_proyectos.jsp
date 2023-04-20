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
                        <link rel="stylesheet" href="../CSS/actualizarProfesor.css">
                        <title>VER PROYECTOS</title>
                    </head>

                    <body>
                        <a href="pre-proyecto.jsp">agregar pre-proyecto</a>
                        <div>
                            <form method="post">
                                <input type="text" id="cedula" name="cedula">
                                <label for="cedula">cedula</label>
                                <button type="submit">BUSCAR</button>
                            </form>
                            <c:if test="${param.cedula!=null}">
                                <sql:query var="result" dataSource="${usuarios}">
                                    select * from general,usuarios
                                    where cargo="estudiante" and estudiante=?
                                    <sql:param value="${param.cedula}">
                                    </sql:param>
                                </sql:query>
                                <table border="1">
                                    <thead>
                                    <td>estado alumno</td>
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
                                                <c:out value="${itema.estado_alumno}" />
                                            </td>
                                            <td>
                                                <c:out value="${itema.pre_proyecto}" />
                                            </td>
                                            <td>
                                                <c:out value="${itema.proyecto}" />
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
                                                <c:out value="${itema.estado_director}" />
                                            </td>
                                            <td>
                                                <c:out value="${itema.estado_evaluador}" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </c:if>
                        </div>
                        <a href="../index.html">CERRAR CESION</a>
                    </body>

                    </html>