<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title><s:message code="producto.ver.label" /></title>
    </head>
    <body>
        <nav class="navbar navbar-fixed-top" role="navigation">
            <ul class="nav">
                <li><a href="<c:url value='/inicio' />"><s:message code="inicio.label" /></a></li>
                <li><a href="<c:url value='/inventario' />"><s:message code="inventario.label" /></a></li>
                <li><a href="<s:url value='/inventario/salida'/>" ><s:message code="salida.lista.label" /></a></li>
                <li><a href="<s:url value='/inventario/entrada'/>" ><s:message code="entrada.lista.label" /></a></li>
                <li class="active"><a href="<s:url value='/inventario/producto'/>" ><s:message code="producto.lista.label" /></a></li>
                <li><a href="<s:url value='/inventario/tipoProducto'/>" ><s:message code="tipoProducto.lista.label" /></a></li>
                <li><a href="<s:url value='/inventario/almacen'/>" ><s:message code="almacen.lista.label" /></a></li>
            </ul>
        </nav>

        <div id="ver-producto" class="content scaffold-list" role="main">
            <h1><s:message code="producto.ver.label" /></h1>

            <p class="well">
                <a class="btn btn-primary" href="<s:url value='/inventario/producto'/>"><i class="icon-list icon-white"></i> <s:message code='producto.lista.label' /></a>
                <a class="btn btn-primary" href="<s:url value='/inventario/producto/nuevo'/>"><i class="icon-file icon-white"></i> <s:message code='producto.nuevo.label' /></a>
            </p>
            <c:if test="${not empty message}">
                <div class="alert alert-block alert-success fade in" role="status">
                    <a class="close" data-dismiss="alert">×</a>
                    <s:message code="${message}" arguments="${messageAttrs}" />
                </div>
            </c:if>

            <c:url var="eliminaUrl" value="/inventario/producto/elimina" />
            <form:form commandName="producto" action="${eliminaUrl}" >
                <form:errors path="*" cssClass="alert alert-error" element="ul" />
                <div class="row-fluid" style="padding-bottom: 10px;">
                    <div class="span4">
                        <h4><s:message code="codigo.label" /></h4>
                        <h3>${producto.codigo}</h3>
                    </div>
                    <div class="span4">
                        <h4><s:message code="sku.label" /></h4>
                        <h3>${producto.sku}</h3>
                    </div>
                </div>
                <div class="row-fluid" style="padding-bottom: 10px;">
                    <div class="span4">
                        <h4><s:message code="nombre.label" /></h4>
                        <h3>${producto.nombre}</h3>
                    </div>
                    <div class="span4">
                        <h4><s:message code="descripcion.label" /></h4>
                        <h3>${producto.descripcion}</h3>
                    </div>
                </div>
                <c:if test="${not empty producto.marca || not empty producto.modelo}">
                    <div class="row-fluid" style="padding-bottom: 10px;">
                        <div class="span4">
                            <h4><s:message code="marca.label" /></h4>
                            <h3>${producto.marca}</h3>
                        </div>
                        <div class="span4">
                            <h4><s:message code="modelo.label" /></h4>
                            <h3>${producto.modelo}</h3>
                        </div>
                    </div>
                </c:if>
                <c:if test="${producto.fraccion || not empty producto.ubicacion}">
                    <div class="row-fluid" style="padding-bottom: 10px;">
                        <div class="span4">
                            <h4><s:message code="fraccion.label" /></h4>
                            <h3><form:checkbox path="fraccion" disabled="true" /></h3>
                        </div>
                        <div class="span4">
                            <h4><s:message code="ubicacion.label" /></h4>
                            <h3>${producto.ubicacion}</h3>
                        </div>
                    </div>
                </c:if>
                <div class="row-fluid" style="padding-bottom: 10px;">
                    <div class="span4">
                        <h4><s:message code="precioUnitario.label" /></h4>
                        <h3>${producto.precioUnitario}</h3>
                    </div>
                    <div class="span4">
                        <h4><s:message code="ultimoPrecio.label" /></h4>
                        <h3>${producto.ultimoPrecio}</h3>
                    </div>
                </div>
                <div class="row-fluid" style="padding-bottom: 10px;">
                    <div class="span4">
                        <h4><s:message code="existencia.label" /></h4>
                        <h3>${producto.existencia} ${producto.unidadMedida}</h3>
                    </div>
                    <div class="span4">
                        <h4><s:message code="iva.label" /></h4>
                        <h3><fmt:formatNumber value="${producto.iva}" type="percent" /></h3>
                    </div>
                </div>
                <div class="row-fluid" style="padding-bottom: 10px;">
                    <div class="span4">
                        <h4><s:message code="puntoReorden.label" /></h4>
                        <h3>${producto.puntoReorden}</h3>
                    </div>
                    <div class="span4">
                        <h4><s:message code="tiempoEntrega.label" /></h4>
                        <h3>${producto.tiempoEntrega}</h3>
                    </div>
                </div>
                <div class="row-fluid" style="padding-bottom: 10px;">
                    <div class="span4">
                        <h4><s:message code="tipoProducto.label" /></h4>
                        <h3>${producto.tipoProducto.nombre}</h3>
                    </div>
                    <div class="span4">
                        <h4><s:message code="almacen.label" /></h4>
                        <h3>${producto.almacen.nombre}</h3>
                    </div>
                </div>

                <p class="well">
                    <a href="<c:url value='/inventario/producto/edita/${producto.id}' />" class="btn btn-primary"><i class="icon-edit icon-white"></i> <s:message code="editar.button" /></a>
                    <form:hidden path="id" />
                    <input type="submit" name="elimina" value="<s:message code='eliminar.button'/>" class="btn btn-danger icon-remove" style="margin-bottom: 2px;" onclick="return confirm('<s:message code="confirma.elimina.message" />');" />
                </p>
            </form:form>
        </div>
    </body>
</html>
