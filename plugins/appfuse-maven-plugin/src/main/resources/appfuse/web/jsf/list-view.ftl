<#assign pojoNameLower = pojo.shortName.substring(0,1).toLowerCase()+pojo.shortName.substring(1)>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:c="http://java.sun.com/jsp/jstl/core"
      xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html"
      xmlns:p="http://primefaces.org/ui">

<f:view>
<f:loadBundle var="text" basename="${'#'}{${pojoNameLower}List.bundleName}"/>
<h:head>
    <title>${'#'}{text['${pojoNameLower}List.title']}</title>
    <meta name="heading" content="${'#'}{text['${pojoNameLower}List.heading']}"/>
    <meta name="menu" content="${pojo.shortName}Menu"/>
</h:head>
<body id="${pojoNameLower}List">

<div class="span10">
    <h2>${'#'}{text['${pojoNameLower}List.heading']}</h2>

    <h:form id="searchForm" styleClass="form-search">
    <div id="search" class="input-append">
        <h:inputText id="q" name="q" size="20" value="${'#'}{${pojoNameLower}List.query}" styleClass="input-medium search-query"/>
        <h:commandButton value="${'#'}{text['button.search']}" styleClass="btn" action="${'#'}{${pojoNameLower}List.search}"/>
    </div>
    </h:form>

    <p>${'#'}{text['${pojoNameLower}List.message']}</p>

    <h:form id="edit${pojo.shortName}">

    <div id="actions" class="form-actions">
        <h:commandButton value="${'#'}{text['button.add']}" action="add" id="add" immediate="true" styleClass="btn btn-primary"/>
        <h:commandButton value="${'#'}{text['button.done']}" action="mainMenu" id="cancel" immediate="true" styleClass="btn"/>
    </div>

    <p:dataTable id="${util.getPluralForWord(pojoNameLower)}" var="${pojoNameLower}" value="${'#'}{${pojoNameLower}List.${util.getPluralForWord(pojoNameLower)}}"
                 sortBy="${'#'}{${pojoNameLower}List.sortColumn}" paginator="true" rows="25"
                 paginatorTemplate="{CurrentPageReport} {FirstPageLink} {PreviousPageLink} {PageLinks} {NextPageLink} {LastPageLink} {RowsPerPageDropdown}"
                 rowsPerPageTemplate="5,10,15">
    <#foreach field in pojo.getAllPropertiesIterator()>
        <p:column>
            <f:facet name="header">
                <p:column sortBy="${field.name}">
                    <h:outputText value="${'#'}{text['${pojoNameLower}.${field.name}']}" />
                </p:column>
            </f:facet>
    <#if field.equals(pojo.identifierProperty)>
            <h:commandLink action="${'#'}{${pojoNameLower}Form.edit}" value="${'#'}{${pojoNameLower}.${field.name}}">
                <f:param name="${field.name}" value="${'#'}{${pojoNameLower}.${field.name}}"/>
                <f:param name="from" value="list"/>
            </h:commandLink>
    <#elseif !c2h.isCollection(field) && !c2h.isManyToOne(field) && !c2j.isComponent(field)>
        <#if field.value.typeName == "java.util.Date" || field.value.typeName == "date">
            <#lt/>    <h:outputText value="${'#'}{${pojoNameLower}.${field.name}}" escape="true"/>
        <#elseif field.value.typeName == "boolean">
            <#lt/>    <h:selectBooleanCheckbox value="${'#'}{${pojoNameLower}Form.${pojoNameLower}.${field.name}}" id="${field.name}" disabled="disabled"/>
        <#else>
            <#lt/>    <h:outputText value="${'#'}{${pojoNameLower}.${field.name}}" escape="true"/>
        </#if>
    </#if>
        </p:column>
    </#foreach>
    </p:dataTable>
    </h:form>
</div>
</body>
</f:view>
</html> 