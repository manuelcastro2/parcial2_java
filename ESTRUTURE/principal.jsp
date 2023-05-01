<!--lIBRERIAS DEL JSTL-->
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
    <title>PRINCIPAL</title>
    <link rel="stylesheet" href="../CSS/principal.css">
</head>
<body>
    <!--DIV QUE ENCIERRA TODO-->
    <div class="caja-todo">
        <!--CONDICIONAL DONDE SE VALIDAD SI ALGUN DATO ESTA VACIO MUESTRE ESTO-->
        <c:if test="${empty param.usuario or empty param.contrasena or empty param.cargo}">
            <!--CAJA ERROR-->
            <div class="caja-error">
                <p>Por favor ingrese su nombre de usuario, password y selecione su cargo</p>
                <a class="button" href="../index.html">Regresar</a>
            </div>
        </c:if>
        <!--CONDICIONAL DONDE SE VALIDAD QUE SI TODOS LOS DATOS ESTAN COMPLETOS MUESTRE LO QUE ESTA DENTRO-->
        <c:if test="${not empty param.usuario and not empty param.contrasena and not empty param.cargo}">
            <!--HAGO UNA CONSULTA DE LOS DATOS RECIBIDOS-->
            <sql:query dataSource="${usuarios}" var="resultado"
                sql="SELECT * FROM usuarios WHERE cedula = ? AND password = ? AND cargo = ?">
                <sql:param value="${param.usuario}" />
                <sql:param value="${param.contrasena}" />
                <sql:param value="${param.cargo}" />
            </sql:query>
            <!--CONDICIONAL SI, DADO AL CASO ENCUENTRA SEMEJANZA EN LA BASE DE DATOS ME DEJE ENTRAR A LA CONDICION-->
            <c:if test="${resultado.rowCount eq 1}">
                <!--CAJA QUE ENCIERRA EL CONTENIDO SIN OCUPAR TODA LA PANTALLA-->
                <div class="caja-intermedia">
                    <!--H2 QUE LA DA LA BIENVENIDAD AL USUARIO-->
                    <h2 class="bienvenido">Bienvenido, ${resultado.rows[0].cargo} - ${resultado.rows[0].nombre}!</h2>
                    <!--CONDICIONAL, SI EL USUARIO TIENE ROL ADMINISTRADOR DEJE ENTRAR-->
                    <c:if test="${resultado.rows[0].cargo =='administrador'}">
                        <!--CONSULTA DE TODOS LOS USUARIOS-->
                        <sql:query var="result" scope="request" dataSource="${usuarios}">
                            select * from usuarios
                        </sql:query>
                        <!--CAJA QUE ENCIERRA EL CONTENIDO-->
                        <div class="caja">
                            <!--TITULO-->
                            <div class="caja-titulo">
                                <h1>DATOS USUARIOS</h1>
                            </div>
                            <!--DIRECCIONAMIENTO A LA PAGINA DE AGREGAR USUARIOS-->
                            <a href="registro.jsp" data-text="Awesome" class="button2">
                                <span class="actual-text">AGREGAR USUARIO</span>
                            </a>
                            <!--TABLA DONDE CARGO LOS DATOS DE LOS USUARIOS-->
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
                                    <!--FOREACH PARA MOSTRAR LOS DATOS-->
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
                                            <!--DIRECCIONAMIENTO A LA PAGINA DE ELIMINAR-->
                                            <td><a class="button3" href="eliminar.jsp?id=${fila.cedula}">Eliminar</a>
                                            </td>
                                            <!--DIRECCIONAMIENTO A LA PAGINA DE ACTUALIZAR-->
                                            <td><a class="button3" href="actualizar.jsp?id=${fila.cedula}">Editar</a>
                                            </td>
                                    </c:forEach>
                                    </tr>
                                </tbody>
                            </table>
                            <!--DIRECCIONAMIENTO DE SALIR DE LA PAGINA PRINCIPAL-->
                            <a class="button4" href="../index.html">cerrar</a>
                        </div>
                    </c:if>
                    <!--CONDICIONAL, SI EL USUARIO TIENE ROL COORDINADOR DEJE ENTRAR-->
                    <c:if test="${resultado.rows[0].cargo =='coordinador'}">
                        <!--DIV QUE ENCIERRA LA INFORMACION DE COORDINADOR-->
                        <div class="caja2">
                            <!--DIRECCIONAMIENTO A LA PAGINA DE VER LOS PROYECTOS DE LOS ESTUDIDANTES-->
                            <a class="button5" href="ver_proyectos.jsp">ver proyectos</a>
                            <!--DIRECCIONAMIENTO A LA PAGINA DE CALENDARIO ACADEMICO-->
                            <a class="button5" target="_blank"
                                href="https://www.uts.edu.co/sitio/wp-content/uploads/normatividad/acuerdos/acu-98.pdf?_t=1664592218">consulta
                                calendario academico</a>
                                <!--DIRECCIONAMIENTO A LA PAGINA DEL FORMATO DE GRADO-->
                            <a class="button5" target="_blank" href="#">consultar formato de grado</a>
                            <!--DIRECCIONAMIENTO A LA PAGINA DE INICIO-->
                            <a class="button5" href="../index.html">cerrar</a>
                        </div>
                    </c:if>
                    <!--VALIDACION SI ES ESTUDIANTE-->
                    <c:if test="${resultado.rows[0].cargo =='estudiante'}">
                        <!--DIV QUE ENCIERRA TODO EL CONTENIDO DE ESTUDIANTE-->
                        <div class="caja-estudiante">
                            <!--CONSULTA DE LA INFORMACION DE ESTUDIANTE-->
                            <sql:query var="result" dataSource="${usuarios}">
                                select * from general,usuarios
                                where cargo="estudiante" and estudiante=?
                                <sql:param value="${param.usuario}">
                                </sql:param>
                            </sql:query>
                            <!--FOREACH PARA MOSTRAR LA INFORMACION DE ESTUDIANTE-->
                            <c:forEach var="itema" items="${result.rows}">
                                <!--CONDICIONALES RESITIVAS PARA SEGUN EL COODINADOR O EL ESTUDIANTE SUBA EL PROYECTO-->
                                <c:if test="${itema.cedula==itema.estudiante}">
                                    <c:if test="${itema.estado_coordinador=='aprobado'}">
                                        <c:if test="${itema.proyecto==''||itema.estado_director=='desaprobado'}">
                                            <!--DIRECIONAMIENTO A LA PAGINA DE SUBIR EL PROYECTO-->
                                            <a class="subir" href="verestudiante.jsp?id=${itema.estudiante}">subir
                                                proyecto</a>
                                        </c:if>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                            <!--DIV QUE ENCIERRA LA INFORMACION-->
                            <div class="datos-estudiante">
                                <h1>INFORMACION</h1>
                                <!--FOREACH PARA MOSTRAR LOS DATOS DEL ESTUDIANTE-->
                                <c:forEach var="itema" items="${result.rows}">
                                    <p>
                                        <c:if test="${itema.cedula==itema.estudiante}">
                                            <c:out value="${'pre-proyecto: '}" /><br>
                                            <c:out value="${itema.pre_proyecto}" />
                                        </c:if>
                                    </p>
                                    <p>
                                        <c:if test="${itema.cedula==itema.estudiante}">
                                            <c:out value="${'proyecto: '}" /><br>
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
                                            <c:out value="${'estudiante: '}" /><br>
                                            <c:out value="${'cc:' }" />
                                            <c:out value="${itema.estudiante}" /><br>
                                            <c:out value="${'Nombre:' }" />
                                            <c:out value="${itema.nombre} ${itema.apellido}" />
                                        </c:if>
                                    </p>
                                    <!--CONSULTA DE LA INFORMACION DEL DIRECTOR-->
                                    <sql:query var="result2" dataSource="${usuarios}">
                                        select * from usuarios
                                        where cedula='${itema.agregar_director}'
                                    </sql:query>
                                </c:forEach>
                                <!--FOREACH PARA MOSTRAR LOS DATOS DEL DIRECTOR-->
                                <c:forEach var="itema2" items="${result2.rows}">
                                    <p>
                                        <c:if test="${itema.cedula==itema.estudiante}">
                                            <c:out value="${'director: '}" /><br>
                                            <c:out value="${'cc: '}" />
                                            <c:out value="${itema2.cedula}" /><br>
                                            <c:out value="${'Nombre: '}" />
                                            <c:out value="${itema2.nombre} ${itema2.apellido}" />
                                        </c:if>
                                    </p>
                                </c:forEach>
                                <!--FOREACH PARA CONTINUAR MOSTRANDO LA INFORMACION DEL ESTUDIANTE-->
                                <c:forEach var="itema" items="${result.rows}">
                                    <!--CONDICIONAL RESTINTIVAS PARA SOLO VER LOS ESTADOS DEL DIRECTOR Y DEL EVALUADOR 
                                    DEL ESTUDIANTE-->
                                    <c:if test="${itema.cedula==itema.estudiante}">
                                        <p>
                                            <c:out value="${'estado coordinador: '}" />
                                            <c:out value="${itema.estado_coordinador}" />
                                        </p>
                                        <!--CONDICIONALES DE MUESTRE DEL ESTADO DEL DIRECTOR-->
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
                                        <!--CONDICIONALES DEL MUESTREO DEL ESTADO DEL EVALUADOR-->
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
                                    </c:if>
                                </c:forEach>
                            </div>
                            <!--DIRECCIONAMIENTO A LA PAGINA DE CALENDARIO ACADEMICO-->
                            <a class="button9" target="_blank"
                                href="https://www.uts.edu.co/sitio/wp-content/uploads/normatividad/acuerdos/acu-98.pdf?_t=1664592218">consulta
                                calendario academico</a>
                                <!--DIRECCIONAMIENTO A LA PAGINA DE FORMATO DE GRADO-->
                            <a class="button9" target="_blank" href="#">consultar formato de grado</a>
                            <!--DIRECCIONAMIENTO A LA PAGINA DE INICIO-->
                            <a class="button9" href="../index.html">cerrar sesion</a>
                        </div>
                    </c:if>
                    <!--CONDICIONAL DEL CARGO DE DIRECTOR-->
                    <c:if test="${resultado.rows[0].cargo =='director'}">
                        <!--CAJA QUE ENCIERRA EL CONTENIDO DE DIRECTOR PERO NO SE MUESTRA EN TODA LA PANTALLA-->
                        <div class="caja3">
                            <!--CONSULTA PARA BUSCAR LA INFORMACION DEL ESTUDIANTE-->
                            <sql:query var="result" dataSource="${usuarios}">
                                select * from general,usuarios
                                where cargo="director" and agregar_director=?
                                <sql:param value="${param.usuario}">
                                </sql:param>
                            </sql:query>
                            <!--FOREACH PARA MOSTRAR LA INFORMACION DEL ESTUDIANTE-->
                            <c:forEach var="itema" items="${result.rows}">
                                <div class="estu">
                                    <h1>estudiante</h1>
                                    <p>
                                        <span>
                                            <c:out value="${'pre-proyecto: '}" />
                                        </span><br>
                                        <c:out value="${itema.pre_proyecto}" />
                                    </p>
                                    <p>
                                        <c:if test="${itema.estado_coordinador=='revision' &&itema.proyecto==''}">
                                            <c:out value="${'pre-proyecto: '}" /><br>
                                            <c:out value="${'proceso espera'}" />
                                        </c:if>
                                        <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto==''}">
                                            <c:out value="${'proyecto: '}" /><br>
                                            <c:out value="${'falta proyecto'}" />
                                        </c:if>
                                        <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto!=''}">
                                            <c:out value="${'proyecto: '}" /><br>
                                            <c:out value="${itema.proyecto}" />
                                        </c:if>
                                    </p>
                                    <p>
                                        <!--CONSULTA PARA EL NOMBRE Y CEDULA DEL ESTUDIANTE-->
                                        <sql:query var="result" dataSource="${usuarios}">
                                            select * from usuarios
                                            where cargo="estudiante" and cedula='${itema.estudiante}'
                                        </sql:query>
                                        <!--FOREACH PARA MOSTRAR ESOS DATOS DE LA CONSULTA-->
                                        <c:forEach var="itema6" items="${result.rows}">
                                            <c:out value="${'estudiante: '}" /><br>
                                            <c:out value="${'cc: '}${itema.estudiante}" /><br>
                                            <c:out value="${'nombre: '}${itema6.nombre} ${itema6.apellido}" />
                                        </c:forEach>
                                    </p>
                                    <!--CONDICIONALES DE MUESTREO DEL ESTADO Y DIRECCIONAMIENTO A LA PAGINA 
                                        VER DIRECTOR-->
                                    <p>
                                        <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto!=''}">
                                            <c:if test="${itema.estado_director==''}">
                                                <c:out value="${'estado: '}" /><br>
                                                <a class="cambiar" href="verdirector.jsp?id=${itema.estudiante}">cambiar
                                                    estado</a>
                                            </c:if>
                                            <c:if test="${itema.estado_director=='desaprobado'}">
                                                <c:out value="${'estado: '}" />
                                                <c:out value="${itema.estado_director}" />
                                                <a class="cambiar"
                                                    href="verdirector.jsp?id=${itema.estudiante}">cambiar</a>
                                            </c:if>
                                            <c:if test="${itema.estado_director=='aprobado'}">
                                                <c:out value=" ${'estado: '}" />
                                                <c:out value="${itema.estado_director}" />
                                            </c:if>
                                        </c:if>
                                    </p>
                                </div>
                            </c:forEach>
                        </div>
                        <!--DIRECCIONAMIENTO A LA PAGINA DE CALENDARIO ACADEMICO-->
                        <a class="button8" target="_blank"
                            href="https://www.uts.edu.co/sitio/wp-content/uploads/normatividad/acuerdos/acu-98.pdf?_t=1664592218">consulta
                            calendario academico</a>
                            <!--DIRECIONAMIENTO DEL FORMATO DE GRADO-->
                        <a class="button8" target="_blank" href="#">consultar formato de grado</a>
                        <!--DIRECCIONAMIENTO A LA PAGINA INICIO-->
                        <a class="button8" href="../index.html">cerrar sesion</a>
                    </c:if>
                    <!--CONDICIONAL DEL ROL EVALUADOR-->
                    <c:if test="${resultado.rows[0].cargo =='evaluador'}">
                        <!--DIV QUE ENCIERRA EL CONTENIDO DE EVALUADOR PERO NO EN TODA LA PANTALLA-->
                        <div class="caja4">
                            <!--CONSULTA SOBRE LA INFORMACION  DE ESTUDIANTE-->
                            <sql:query var="result" dataSource="${usuarios}">
                                select * from general
                                where estado_director='aprobado'
                            </sql:query>
                            <!--FOREACH PARA MOSTRAR LA INFORMACION DEL ESTUDIANTE-->
                            <c:forEach var="itema" items="${result.rows}">
                                <!--DIV QUE ENCIERRA LA INFORMACION DEL ESTUDIANTE-->
                                <div class="caja-evaluador">
                                    <h1>estudiante</h1>
                                    <p>
                                        <c:out value="${'pre-proyecto: '}" /><br>
                                        <c:out value="${itema.pre_proyecto}" />
                                    </p>
                                    <p>
                                        <c:if test="${itema.estado_coordinador=='revision' &&itema.proyecto==''}">
                                            <c:out value="${'pre-proyecto: '}" /><br>
                                            <c:out value="${'proceso espera'}" />
                                        </c:if>
                                        <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto==''}">
                                            <c:out value="${'proyecto: '}" /><br>
                                            <c:out value="${'falta proyecto'}" />
                                        </c:if>
                                        <c:if test="${itema.estado_coordinador=='aprobado' &&itema.proyecto!=''}">
                                            <c:out value="${'proyecto: '}" /><br>
                                            <c:out value="${itema.proyecto}" />
                                        </c:if>
                                    </p>
                                    <p>
                                        <!--CONSULTA SOBRE LA INFORMACION DEL ESTUDANTE-->
                                        <sql:query var="result" dataSource="${usuarios}">
                                            select * from usuarios
                                            where cargo="estudiante" and cedula='${itema.estudiante}'
                                        </sql:query>
                                        <!--MUESTREO DE LA INFORMACION DEL ESTUDIANTE-->
                                        <c:forEach var="itema6" items="${result.rows}">
                                            <c:out value="${'estudiante: '}" /><br>
                                            <c:out value="${'cedula: '} ${itema.estudiante}" /><br>
                                            <c:out value="${'nombre: '} ${itema6.nombre} ${itema6.apellido}" />
                                        </c:forEach>
                                    </p>
                                    <p>
                                        <c:if test="${itema.estado_director=='aprobado'}">
                                            <c:out value=" ${'estado director: '} ${itema.estado_director}" />
                                        </c:if>

                                    </p>
                                    <!--CONDICIONALES DEL ESTADO DEL EVALUADOR-->
                                    <p>
                                        <c:if test="${itema.estado_director=='aprobado'}">
                                            <c:if test="${itema.estado_evaluador==''}">
                                                <c:out value="${'estado: '}" />
                                                <!--FORM PARA ENVIAR DATOS DEL ESTUDIANTE A LA PAGINA DE VEREVALUADOR-->
                                                <form action="verevaluador.jsp" method="post">
                                                    <input type="hidden" id="estu" name="estu"
                                                        value="${itema.estudiante}">
                                                    <input type="hidden" id="cedu" name="cedu"
                                                        value="${resultado.rows[0].cedula}">
                                                    <button class="button11" type="submit">cambiar</button>
                                                </form>
                                            </c:if>
                                            <c:if test="${itema.estado_evaluador=='desaprobado'}">
                                                <c:out value="${'estado: '} ${itema.estado_evaluador}" />
                                                <!--FORM PARA ENVIAR DATOS DEL ESTUDIANTE A LA PAGINA DE VEREVALUADOR-->
                                                <form action="verevaluador.jsp" method="post">
                                                    <input type="hidden" id="id" name="id" value="${itema.estudiante}">
                                                    <input type="hidden" id="cedu" name="cedu"
                                                        value="${resultado.rows[0].cedula}">
                                                    <button class="button11" type="submit">cambiar</button>
                                                </form>
                                            </c:if>
                                            <c:if test="${itema.estado_evaluador=='aprobado'}">
                                                <c:out value=" ${'estado: '} ${itema.estado_evaluador}" />
                                            </c:if>
                                        </c:if>
                                    </p>
                                </div>
                            </c:forEach>


                        </div>
                        <!--DIRECCIONAMIENTO A LA PAGINA DE CALENDARIO ACADEMICO-->
                        <a class="button10" target="_blank"
                            href="https://www.uts.edu.co/sitio/wp-content/uploads/normatividad/acuerdos/acu-98.pdf?_t=1664592218">consulta
                            calendario academico</a>
                            <!--DIRECCIONAMIENTO A AL PAGINA DE FORMATO DE GRADO-->
                        <a class="button10" target="_blank" href="#">consultar formato de grado</a>
                        <!--DIRECCIONAMIENTO A LA PAGINA INICIO-->
                        <a class="button10" href="../index.html">cerrar sesion</a>
                    </c:if>
                </div>
            </c:if>
            <!--CONDICIONAL DE QUE SI NO ENCONTRARON EL USUARIO MUESTRE ESTO-->
            <c:if test="${resultado.rowCount eq 0}">
                <div class="caja-error">
                    <p>Usuario, password o cargo incorrectos. Por favor, intente de nuevo.</p>
                    <a class="button" href="../index.html">Regresar</a>
                </div>
            </c:if>
        </c:if>
    </div>
</body>
</html>