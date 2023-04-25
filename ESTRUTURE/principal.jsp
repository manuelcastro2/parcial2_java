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
    <div class="caja-todo">
        <c:if test="${empty param.usuario or empty param.contrasena or empty param.cargo}">
            <div class="caja-error">
                <p>Por favor ingrese su nombre de usuario, password y selecione su cargo</p>
                <a class="button" href="../index.html">Regresar</a>
            </div>
        </c:if>
        <c:if test="${not empty param.usuario and not empty param.contrasena and not empty param.cargo}">
            <sql:query dataSource="${usuarios}" var="resultado"
                sql="SELECT * FROM usuarios WHERE cedula = ? AND password = ? AND cargo = ?">
                <sql:param value="${param.usuario}" />
                <sql:param value="${param.contrasena}" />
                <sql:param value="${param.cargo}" />
            </sql:query>
            <c:if test="${resultado.rowCount eq 1}">
                <div class="caja-intermedia">
                    <h2 class="bienvenido">Bienvenido, ${resultado.rows[0].cargo} - ${resultado.rows[0].nombre}!</h2>
                    <c:if test="${resultado.rows[0].cargo =='administrador'}">

                        <sql:query var="result" scope="request" dataSource="${usuarios}">
                            select * from usuarios
                        </sql:query>
                        <div class="caja">
                            <div class="caja-titulo">
                                <h1>DATOS USUARIOS</h1>
                            </div>
                            <a href="registro.jsp" data-text="Awesome" class="button2">
                                <span class="actual-text">AGREGAR USUARIO</span>
                            </a>
                            <table class="item tres">
                                <thead>
                                    <tr>
                                        <th> cedula</th>
                                        <th>nombre</th>
                                        <th>apellido</th>
                                        <th>cargo</th>
                                        <th>password</th>
                                        <th colspan="2">acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="fila" items="${result.rows}">
                                        <tr>
                                            <td>
                                                <c:out value="${fila.cedula}" />
                                            </td>
                                            <td>
                                                <c:out value="${fila.nombre}" />
                                            </td>
                                            <td>
                                                <c:out value="${fila.apellido}" />
                                            </td>
                                            <td>
                                                <c:out value="${fila.cargo}" />
                                            </td>
                                            <td>
                                                <c:out value="${fila.password}" />
                                            </td>
                                            <td><a class="button3" href="eliminar.jsp?id=${fila.cedula}">Eliminar</a>
                                            </td>
                                            <td><a class="button3" href="actualizar.jsp?id=${fila.cedula}">Editar</a>
                                            </td>
                                    </c:forEach>
                                    </tr>
                                </tbody>
                            </table>
                            <a class="button4" href="../index.html">cerrar</a>
                        </div>
                    </c:if>

                    <c:if test="${resultado.rows[0].cargo =='coordinador'}">
                        <div class="caja2">
                            <a class="button5" href="ver_proyectos.jsp">ver proyectos</a>
                            <a class="button5" href="#">consulta calendario academico</a>
                            <a class="button5" href="#">consultar formato de grado</a>
                            <a class="button5" href="../index.html">cerrar</a>
                        </div>
                    </c:if>

                    <c:if test="${resultado.rows[0].cargo =='estudiante'}">
                        <sql:query var="result" dataSource="${usuarios}">
                            select * from general,usuarios
                            where cargo="estudiante" and estudiante=?
                            <sql:param value="${param.usuario}">
                            </sql:param>
                        </sql:query>
                        <c:forEach var="itema" items="${result.rows}">
                            <c:if test="${itema.cedula==itema.estudiante}">
                                <c:if test="${itema.estado_coordinador=='aprobado'}">
                                    <c:if test="${itema.proyecto==''||itema.estado_director=='desaprobado'}">
                                        <a href="verestudiante.jsp?id=${itema.estudiante}">subir proyecto</a>
                                    </c:if>
                                </c:if>
                            </c:if>
                        </c:forEach>

                        <div>
                            <c:forEach var="itema" items="${result.rows}">
                                <p>

                                    <c:if test="${itema.cedula==itema.estudiante}">
                                        <c:out value="${'pre-proyecto: '}" />
                                        <c:out value="${itema.pre_proyecto}" />
                                    </c:if>
                                </p>
                                <p>
                                    <c:if test="${itema.cedula==itema.estudiante}">
                                        <c:out value="${'proyecto: '}" />
                                        <c:if test="${itema.estado_coordinador=='revision'}">
                                            <c:out value="${'aun no se puede subir proyecto'}" />
                                        </c:if>
                                        <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto==''}">
                                            <c:out value="${'ya se puede subir'}" />
                                        </c:if>
                                        <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto!=''}">
                                            <c:out value="${itema.proyecto}" />
                                        </c:if>
                                    </c:if>
                                </p>
                                <p>
                                    <c:if test="${itema.cedula==itema.estudiante}">
                                        <c:out value="${'estudiante: '}" />
                                        <c:out value="${itema.estudiante}" />
                                        <c:out value="${itema.nombre} ${itema.apellido}" />
                                    </c:if>
                                </p>
                                <sql:query var="result2" dataSource="${usuarios}">
                                    select * from usuarios
                                    where cedula='${itema.agregar_director}'
                                </sql:query>
                            </c:forEach>
                            <c:forEach var="itema2" items="${result2.rows}">
                                <p>
                                    <c:if test="${itema.cedula==itema.estudiante}">
                                        <c:out value="${'director: '}" />
                                        <c:out value="${itema2.cedula}" />
                                        <c:out value="${itema2.nombre} ${itema2.apellido}" />
                                    </c:if>
                                </p>
                            </c:forEach>
                            <c:forEach var="itema" items="${result.rows}">
                                <c:if test="${itema.cedula==itema.estudiante}">
                                    <p>
                                        <c:out value="${'estado coordinador: '}" />
                                        <c:out value="${itema.estado_coordinador}" />
                                    </p>
                                    <p>
                                        <c:out value="${'estado director : '}" />
                                        <c:if
                                            test="${itema.estado_coordinador=='aprobado' && itema.estado_director!=''}">
                                            <c:out value="${itema.estado_director}" />
                                        </c:if>
                                        <c:if
                                            test="${itema.estado_coordinador=='aprobado' && itema.estado_director==''}">
                                            <c:out value="${'No revisado'}" />
                                        </c:if>
                                    </p>
                                    <p>
                                        <c:out value="${'estado evaluador: '}" />
                                        <c:if
                                            test="${itema.estado_coordinador=='aprobado' && itema.estado_evaluador!=''}">
                                            <c:out value="${itema.estado_evaluador}" />
                                        </c:if>
                                        <c:if
                                            test="${itema.estado_coordinador=='aprobado' && itema.estado_evaluador==''}">
                                            <c:out value="${'No revisado'}" />
                                        </c:if>

                                    </p>
                                    <p>
                                        <c:if test="${itema.estado_evaluador!='' && itema.calificacion!=''}">
                                            <c:out value="${'calificacion: '}" />
                                            <c:out value="${itema.calificacion}" />
                                        </c:if>
                                    </p>
                                </c:if>
                            </c:forEach>
                        </div>

                        <a href="#">consulta calendario academico</a>
                        <a href="#">consultar formato de grado</a>
                        <a href="../index.html">cerrar sesion</a>
                    </c:if>

                    <c:if test="${resultado.rows[0].cargo =='director'}">
                        <div class="caja3">
                            <sql:query var="result" dataSource="${usuarios}">
                                select * from general,usuarios
                                where cargo="director" and agregar_director=?
                                <sql:param value="${param.usuario}">
                                </sql:param>
                            </sql:query>

                            <div class="estu">
                                <c:forEach var="itema" items="${result.rows}">
                                    <h1>estudiante</h1>
                                    <p>
                                        <c:out value="${'pre-proyecto: '}${itema.pre_proyecto}" />
                                    </p>
                                    <p>
                                        <c:if test="${itema.estado_coordinador=='revision' &&itema.proyecto==''}">
                                            <c:out value="${'pre-proyecto: '}${'proceso espera'}" />
                                        </c:if>
                                        <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto==''}">
                                            <c:out value="${'proyecto: '}${'falta proyecto'}" />
                                        </c:if>
                                        <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto!=''}">
                                            <c:out value="${'proyecto: '}${itema.proyecto}" />
                                        </c:if>
                                    </p>
                                    <p>
                                        <sql:query var="result" dataSource="${usuarios}">
                                            select * from usuarios
                                            where cargo="estudiante" and cedula='${itema.estudiante}'
                                        </sql:query>
                                        <c:forEach var="itema6" items="${result.rows}">
                                            <c:out value="${'estudiante: '}" />
                                            <c:out value="${'cedula: '}${itema.estudiante}" />
                                            <c:out value="${'nombre: '}${itema6.nombre} ${itema6.apellido}" />
                                        </c:forEach>
                                    </p>
                                    <p>
                                        <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto!=''}">
                                            <c:if test="${itema.estado_director==''}">
                                                <c:out value="${'estado: '}" />
                                                <a href="verdirector.jsp?id=${itema.estudiante}">cambiar estado</a>
                                            </c:if>
                                            <c:if test="${itema.estado_director=='desaprobado'}">
                                                <c:out value="${'estado: '} ${itema.estado_director}" />
                                                <a href="verdirector.jsp?id=${itema.estudiante}">cambiar</a>
                                            </c:if>
                                            <c:if test="${itema.estado_director=='aprobado'}">
                                                <c:out value=" ${'estado: '} ${itema.estado_director}" />
                                            </c:if>
                                        </c:if>
                                    </p>
                                </c:forEach>
                            </div>
                        </div>
                        <a href="#">consulta calendario academico</a>
                        <a href="#">consultar formato de grado</a>
                        <a href="../index.html">cerrar sesion</a>
                    </c:if>


                    <c:if test="${resultado.rows[0].cargo =='evaluador'}">

                        <div>
                            <sql:query var="result" dataSource="${usuarios}">
                                select * from general
                                where estado_director='aprobado'
                            </sql:query>

                            <div>
                                <c:forEach var="itema" items="${result.rows}">
                                    <h1>estudiante</h1>
                                    <p>
                                        <c:out value="${'pre-proyecto: '}${itema.pre_proyecto}" />
                                    </p>
                                    <p>
                                        <c:if test="${itema.estado_coordinador=='revision' &&itema.proyecto==''}">
                                            <c:out value="${'pre-proyecto: '}${'proceso espera'}" />
                                        </c:if>
                                        <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto==''}">
                                            <c:out value="${'proyecto: '}${'falta proyecto'}" />
                                        </c:if>
                                        <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto!=''}">
                                            <c:out value="${'proyecto: '}${itema.proyecto}" />
                                        </c:if>
                                    </p>
                                    <p>
                                        <sql:query var="result" dataSource="${usuarios}">
                                            select * from usuarios
                                            where cargo="estudiante" and cedula='${itema.estudiante}'
                                        </sql:query>
                                        <c:forEach var="itema6" items="${result.rows}">
                                            <c:out value="${'estudiante: '}" />
                                            <c:out value="${'cedula: '}${itema.estudiante}" />
                                            <c:out value="${'nombre: '}${itema6.nombre} ${itema6.apellido}" />
                                        </c:forEach>
                                    </p>
                                    <p>
                                        <c:if test="${itema.estado_director=='aprobado'}">
                                            <c:out value=" ${'estado director: '} ${itema.estado_director}" />
                                        </c:if>

                                    </p>
                                    <p>
                                        <c:if test="${itema.estado_director=='aprobado'}">
                                            <c:if test="${itema.estado_evaluador==''}">
                                                <c:out value="${'estado: '}" />
                                                <form action="verevaluador.jsp" method="post">
                                                    <input type="hidden" id="estu" name="estu"
                                                        value="${itema.estudiante}">
                                                    <input type="hidden" id="cedu" name="cedu"
                                                        value="${resultado.rows[0].cedula}">
                                                    <button type="submit">cambiar</button>
                                                </form>
                                            </c:if>
                                            <c:if test="${itema.estado_evaluador=='desaprobado'}">
                                                <c:out value="${'estado: '} ${itema.estado_evaluador}" />
                                                <form action="verevaluador.jsp" method="post">
                                                    <input type="hidden" id="id" name="id" value="${itema.estudiante}">
                                                    <input type="hidden" id="cedu" name="cedu"
                                                        value="${resultado.rows[0].cedula}">
                                                    <button type="submit">cambiar</button>
                                                </form>
                                            </c:if>
                                            <c:if test="${itema.estado_evaluador=='aprobado'}">
                                                <c:out value=" ${'estado: '} ${itema.estado_evaluador}" />
                                            </c:if>
                                        </c:if>
                                    </p>

                                </c:forEach>

                            </div>
                        </div>
                        <a href="#">consulta calendario academico</a>
                        <a href="#">consultar formato de grado</a>
                        <a href="../index.html">cerrar sesion</a>
                    </c:if>

                    <c:if test="${resultado.rowCount eq 0}">
                        <div class="caja-error">
                            <p>Usuario, password o cargo incorrectos. Por favor, intente de nuevo.</p>
                            <a class="button" href="../index.html">Regresar</a>
                        </div>
                    </c:if>
                </div>
            </c:if>
        </c:if>
    </div>
</body>

</html>