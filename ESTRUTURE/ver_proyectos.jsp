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
                                <input type="hidden" id="validacion" value="si">
                                <button type="submit">BUSCAR</button>
                            </form>
                            <c:if test="validacion!=null">
                                <sql:query var="result" scope="request" dataSource="${usuarios}">
                                    select * from estudiante,estado,usuarios 
                                    where estado.estudiante=estudiante.estudiante_usuario 
                                    and estudiante.estudiante_usuario=usuario.cedula
                                    and estudiante_usuario=?
                                </sql:query value="${param.cedula}">
                                <table>
                                    <th>
                                    <td>
                                        pre-proyecto
                                    </td>
                                    <td>
                                        proyecto
                                    </td>
                                    <td colspan="2">
                                        estudiante
                                    </td>
                                    <td>
                                        aprobado
                                    </td>
                                    <td colspan="3">estado</td>
                                    </th>
                                    <c:forEach var="itema" items="${result.rows}">
                                        <tr>
                                            <td>
                                                <c:out value="${itema.pre_proyecto}" />
                                            </td>
                                            <td>
                                                <c:out value="${itema.proyecto}" />
                                            </td>
                                            <td>
                                                <c:out value="${itema.estudiante_usuario}" />
                                            </td>
                                            <td>
                                                <c:out value="${itema.nombre}" />
                                            </td>
                                            <td>
                                               <c:if test="${itema.estudiante_usuario}">
                                                <c:out value="${itema.aprobado}" />
                                               </c:if>
                                            </td>

                                        </tr>
                                    </c:forEach>
                                </table>
                            </c:if>
                        </div>
                    </body>

                    </html>