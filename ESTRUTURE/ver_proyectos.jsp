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
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../CSS/ver_proyectos.css">
    <title>VER PROYECTOS</title>
</head>

<body>
    <!--DIV QUE ENCIERRA TODO-->
    <div class="caja-todo">
        <!--DIV QUE ENCIERRA EL CONTENIDO PERO NO SE MUESTRA EN TODA LA PANTALLA-->
        <div class="caja-intermedia">
            <!--DIV TITULO-->
            <div class="titulo">
                <h1>PRE-PROYECTOS</h1>
            </div>
            <div class="ir">
                <!--DIRECCIONAMIENTO A AGREGAR PROYECTO-->
                <a class="button6" href="pre-proyecto.jsp">agregar pre-proyecto</a>
            </div>
            <!--DIV QUE ENCIERRA AL BUSCADOR-->
            <div class="buscador">
                <form method="post">
                    <input type="text" id="cedula" name="cedula" placeholder="Cedula"><br>
                    <button class="button5" id="buscar" type="submit">BUSCAR</button>
                </form>
            </div>
            <!--CONDICIONAL SI EL DATO NO ESTA VACIO ENTRE-->
            <c:if test="${param.cedula!=null || param.cedula!=''}">
                <!--CONSULTA DEL ESTUDIANTE-->
                <sql:query var="result" dataSource="${usuarios}">
                    select * from general,usuarios
                    where cargo="estudiante" and estudiante=?
                    <sql:param value="${param.cedula}">
                    </sql:param>
                </sql:query>
                <!--DIV QUE ENCIERRA LA INFORMACION DEL ESTUDIANTE-->
                <div class="estudiante">
                    <h1>
                        <c:out value="${'ESTUDIANTE'}" />
                    </h1>
                    <c:forEach var="itema" items="${result.rows}">
                        <c:if test="${itema.cedula==itema.estudiante}">
                            <p>
                                <span>
                                    <c:out value="${'PRE-PROYECTO: '}" />
                                </span>
                                <c:out value="${itema.pre_proyecto}" />
                            </p>
                            <p>
                                <span>
                                    <c:out value="${'PROYECTO: '}" />
                                </span>
                                <c:out value="${itema.proyecto}" />
                            </p>
                            <p>
                                <span>
                                    <c:out value="${'estudiante:'}" />
                                </span><br>
                                <span>
                                    <c:out value="${'cc: '}" />
                                </span>
                                <c:out value="${itema.estudiante}" /><br>
                                <span>
                                    <c:out value="${'nombre:'} " />
                                </span>
                                <c:out value="${itema.nombre} ${itema.apellido} " />
                            </p>
                            <!--CONSULTA LA INFORMACION DEL DIRECTOR-->
                            <sql:query var="result2" dataSource="${usuarios}">
                                select * from usuarios
                                where cedula='${itema.agregar_director}'
                            </sql:query>
                        </c:if>
                    </c:forEach>
                    <c:forEach var="itema2" items="${result2.rows}">
                        <pv>
                            <span>
                                <c:out value="${'director: '}" />
                            </span><br>
                            <span>
                                <c:out value="${'cedula: '}" />
                            </span>
                            <c:out value="${itema2.cedula}" /><br>
                            <span>
                                <c:out value="${'nombre: '}" />
                            </span>
                            <c:out value="${itema2.nombre} ${itema2.apellido}" />
                            </p>
                    </c:forEach>
                    <c:forEach var="itema" items="${result.rows}">
                        <c:if test="${itema.cedula==itema.estudiante}">
                            <p>
                                <span>
                                    <c:out value="${'estado coordinador:'}" />
                                </span>
                                <c:if test="${itema.estado_coordinador=='desaprobado'}">
                                    <font color="red"><c:out value="${itema.estado_coordinador}" /></font>
                                </c:if>
                                <c:if test="${itema.estado_coordinador=='aprobado'}">
                                    <font><c:out value="${itema.estado_coordinador}" /></font>
                                </c:if>
                            </p>
                        </c:if>
                        <!--CONDICIONAL DEL MOSTRADO DEL DIRECTOR-->
                        <c:if test="${itema.cedula==itema.estudiante}">
                            <p>
                                <span>
                                    <c:out value="${'estado director:'}" />
                                </span>
                                <c:if test="${itema.estado_director!=''}">
                                </c:if>
                                <c:out value="${itema.estado_director}" />
                                <c:if test="${itema.estado_director==''}">
                                    <c:out value="${'no revisado'}" />
                                </c:if>
                            </p>
                        </c:if>
                        <!--CONDICIONAL DEL EVALUADOR-->
                        <c:if test="${itema.cedula==itema.estudiante}">
                            <p>
                                <span>
                                    <c:out value="${'estado evaluador:'}" />
                                </span>
                                <c:if test="${itema.estado_evaluador!=''}">
                                    <c:out value="${itema.estado_evaluador}" />
                                </c:if>
                                <c:if test="${itema.estado_evaluador==''}">
                                    <c:out value="${'no revisado'}" />
                                </c:if>
                            </p>
                        </c:if>
                        <!--CONDICIONAL Y MODIFICACION DEL ESTADO DEL COORDINADOR-->
                        <c:if test="${itema.cedula==itema.estudiante}">
                            <c:if test="${itema.estado_coordinador=='revision'}">
                                <p>
                                    <c:if test="${param.modificar==null}">
                                        <form method="post">
                                            <select name="est_coordinador" id="est_coordinador">
                                                <option value="aprobado">aprobado</option>
                                                <option value="desaprobado">no aprobado</option>
                                            </select>
                                            <input type="hidden" name="modificar" id="modificar"
                                                value="${itema.estudiante}">
                                            <button class="button8" type="submit">cambiar</button>
                                        </form>
                                    </c:if>
                                </p>
                            </c:if>
                        </c:if>
                    </c:forEach>
                    <!--CONDICIONAL SI EL ESTUDIANTE NO TIENE PROYECTO REGISTRADO MUESTRE ESTO-->
                    <c:if test="${result.rowCount eq 0}">
                        <p>el estudiante no tiene proyecto</p>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>
    <!--CONDICIONAL DEL ENVIO DEL ESTADO DEL COORDINADOR-->
    <c:if test="${param.modificar!=null}">
        <!--SQL UPDATE-->
        <sql:update var="result" dataSource="${usuarios}">
            update general set estado_coordinador="${param.est_coordinador}"
            where estudiante='${param.modificar}'
        </sql:update>
    </c:if>
    <!--DIRECCIONAMIENTO A LA PAGINA INICIO-->
    <a class="button7" href="../index.html">CERRAR CESION</a>
</body>

</html>