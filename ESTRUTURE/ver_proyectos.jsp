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
            <div>
                <c:forEach var="itema" items="${result.rows}">
                    <c:if test="${itema.cedula==itema.estudiante}">
                        <p>
                            <c:out value="${'PRE-PROYECTO: '}${itema.pre_proyecto}" />
                        </p>
                        <p>
                            <c:out value="${'PROYECTO: '}${itema.proyecto}" />
                        </p>
                        <div>
                            <c:out value="${'estudiente:'}" />
                            <c:out value="${'cc: '}${itema.estudiante}" />
                            <c:out value="${'nombre:'}${itema.nombre} ${itema.apellido} " />
                        </div>
                        <sql:query var="result2" dataSource="${usuarios}">
                            select * from usuarios
                            where cedula='${itema.agregar_director}'
                        </sql:query>
                    </c:if>
                </c:forEach>
                <c:forEach var="itema2" items="${result2.rows}">
                    <div>
                        <c:out value="${'director: '}" />
                        <c:out value="${'cedula: '}${itema2.cedula}" />
                        <c:out value="${'nombre: '}${itema2.nombre} ${itema2.apellido}" />
                    </div>
                </c:forEach>
                <c:forEach var="itema" items="${result.rows}">

                    <p>
                        <c:if test="${itema.cedula==itema.estudiante}">
                            <c:out value="${'estado coordinador:'}" />
                            <c:out value="${itema.estado_coordinador}" />
                        </c:if>
                    </p>
                    <p>
                        <c:if test="${itema.cedula==itema.estudiante}">
                            <c:out value="${'estado director:'}" />
                            <c:if test="${itema.estado_director!=''}">
                            </c:if>
                            <c:out value="${itema.estado_director}" />
                            <c:if test="${itema.estado_director==''}">
                                <c:out value="${'no revisado'}" />
                            </c:if>
                        </c:if>
                    </p>
                    <p>
                        <c:if test="${itema.cedula==itema.estudiante}">
                            <c:out value="${'estado evaluador:'}" />
                            <c:if test="${itema.estado_evaluador!=''}">
                                <c:out value="${itema.estado_evaluador}" />
                            </c:if>
                            <c:if test="${itema.estado_evaluador==''}">
                                <c:out value="${'no revisado'}" />
                            </c:if>
                        </c:if>
                    </p>
                    <c:if test="${itema.cedula==itema.estudiante}">
                        <c:if test="${itema.estado_coordinador=='revision'}">
                            <p>
                                <c:if test="${param.modificar==null}">
                                    <form method="post">
                                        <select name="est_coordinador" id="est_coordinador">
                                            <option value="aprobado">aprobado</option>
                                            <option value="no aprobado">no aprobado</option>
                                        </select>
                                        <input type="hidden" name="modificar" id="modificar"
                                            value="${itema.estudiante}">
                                        <button type="submit">cambiar</button>
                                    </form>
                                </c:if>
                            </p>
                        </c:if>
                    </c:if>

                </c:forEach>
            </div>
        </c:if>
    </div>
    <c:if test="${param.modificar!=null}">
        <sql:update var="result" dataSource="${usuarios}">
            update general set estado_coordinador="${param.est_coordinador}"
            where estudiante='${param.modificar}'
        </sql:update>
    </c:if>
    <a href="../index.html">CERRAR CESION</a>
</body>

</html>