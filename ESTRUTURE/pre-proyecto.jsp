<!--LIBRERIAS DEL JSTL-->
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
    <link rel="stylesheet" href="../CSS/agregar_proyecto.css">
    <title>SUBIENDO PRE-PROYECTO</title>
</head>

<body>
    <!--CAJA QUE ENCIERRA TODO EL CONTENIDO EN LA PARALLA-->
    <div class="caja-todo">
        <!--CAJA QUE ENCIERRA TOOD EL CONTENIDO PERO NO SE MUESTRA EN TODA LA PANTALLA-->
        <div class="caja-intermedia">
            <!--CONSULTA SQL-->
            <sql:query var="result" dataSource="${usuarios}">
                select * from usuarios,general
            </sql:query>
            <!--CONDICIONAL SI EL COORDINADOR NO HA COLOCADO EL PREPROYECTO-->
            <c:if test="${param.pre==null}">
            <h1>SUBIENDO PRE-PROYECTO</h1>
                <form method="post">
                    <!--CAJA QUE ENCIERRA EL CONTENIDO DE INTERACCION-->
                    <div class="caja-contenido">
                        <input type="text" id="pre" name="pre" placeholder="pre proyecto">
                    <select name="estudiante" id="estudiante">
                        <option value="">estudiante</option>
                        <!--FOREACH PARA LLAMAR LOS DATOS DEL ESTUDIANTE-->
                        <c:forEach var="itema" items="${result.rows}">
                            <c:if test="${itema.cargo=='estudiante'&&itema.pre_proyecto==null}">
                                <option value="${itema.cedula}">
                                    <c:out value="${itema.cedula}" /> -
                                    <c:out value="${itema.nombre}" />
                                    <c:out value="${itema.apellido}" />
                                </option>
                            </c:if>
                        </c:forEach>
                    </select>
                    <select name="director" id="director">
                        <option>director</option>
                        <!--FOREACH PARA LLAMAR LOS DATOS DEL DIRECTOR-->
                        <c:forEach var="itema" items="${result.rows}">
                            <c:if test="${itema.cargo=='director'}">
                                <option value="${itema.cedula}">
                                    <c:out value="${itema.cedula}" /> -
                                    <c:out value="${itema.nombre}" />
                                    <c:out value="${itema.apellido}" />
                                </option>
                            </c:if>
                        </c:forEach>
                    </select>
                    <!--ESTADOS DEL COORDINADOR-->
                    <select name="est_coordinador" id="est_coordinador">
                        <option value="revision">Revision</option>
                        <option value="aprobado">Aprobado</option>
                        <option value="no aprobado">Desaprobado</option>
                    </select>

                    <button type="submit">Subir</button>
                    </div>
                </form>
            </c:if>
            <!--CONDICIONAL SI LA COORDINADORA YA COLOCO EL PREPROYECTO-->
            <c:if test="${param.pre!=null}">
                <!--MANDO LOS DATOS A LA BASE-->
                <sql:update var="result" dataSource="${usuarios}">
                    insert into general
                    (pre_proyecto,proyecto,estudiante,agregar_director,estado_coordinador,estado_director,estado_evaluador,calificacion)
                    values('${param.pre}','','${param.estudiante}','${param.director}','${param.est_coordinador}','','','')
                </sql:update>
                <c:if test="${result == 1}">
                    <!--MUESTRO ESTO AL HACER LA INSERTACION-->
                   <div class="resultado">
                         <h1 class="caja-titulo2">PRE-PROYECTO AGREGADO CORRECTAMENTE</h1>
                    <form method="post" action="ver_proyectos.jsp">
                        <button type="submit">
                            <span>REGRESAR</span>
                        </button>
                    </form>
                    <br>
                    <a href="pre-proyecto.jsp">INGREDAR OTRO PRE-PROYECTO</a>
                   </div>
                </c:if>
            </c:if>
        </div>
    </div>
</body>

</html>