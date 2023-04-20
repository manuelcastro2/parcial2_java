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
    <title>SUBIENDO</title>
</head>
<body>
<h1>SISTEMA UNIVERSITARIO</h1>
<h2>SUBIENDO PRE-PROYECTO</h2>
<sql:query var="result" dataSource="${usuarios}">
select * from usuarios
</sql:query>
<c:if test="${param.pre==null}">
<form method="post">
    <label for="pre">pre-proyecto</label>
    <input type="text" id="pre" name="pre">
    <label for="estudiante">estudiante</label>
    <select name="estudiante" id="estudiante">
        <c:forEach var="itema" items="${result.rows}">
            <c:if test="${itema.cargo=='estudiante'}">
                <option value="${itema.cedula}"><c:out value="${itema.cedula}"/> - <c:out value="${itema.nombre}"/> <c:out value="${itema.apellido}"/></option>
            </c:if>
        </c:forEach>
    </select>
    <label for="director">Director</label>
    <select name="director" id="director">
        <c:forEach var="itema" items="${result.rows}">
            <c:if test="${itema.cargo=='director'}">
                <option value="${itema.cedula}"><c:out value="${itema.cedula}"/> - <c:out value="${itema.nombre}"/> <c:out value="${itema.apellido}"/></option>
            </c:if>
        </c:forEach>
    </select>
<select name="est_coordinador" id="est_coordinador">
        <option value="revision">No Asignar</option>
        <option value="aprobado">aprobado</option>
        <option value="no aprobado">no aprobado</option>
    </select>

        <button type="submit">Subir</button>
</form>
</c:if>
<c:if test="${param.pre!=null}">
                    <sql:update var="result" dataSource="${usuarios}">
insert into general (pre_proyecto,proyecto,estudiante,agregar_director,estado_coordinador,estado_director,estado_evaluador,calificacion)
                    values('${param.pre}','','${param.estudiante}','${param.director}','${param.est_coordinador}','','','')
                    </sql:update>  
                <c:if test="${result == 1}">
                    <h1 class="caja-titulo2">PRE-PROYECTO AGREGADO CORRECTAMENTE</h1>
                    
                     <form method="post" action="ver_proyectos.jsp">
                        <button type="submit">
                             <span>REGRESAR</span> 
                         </button>
                    </form>
                    <a href="pre-proyecto.jsp">INGREDAR OTRO PRE-PROYECTO</a>
                </c:if>  
</c:if>  
    
</body>
</html>