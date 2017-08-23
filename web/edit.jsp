<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Practice 2</title>
    <link rel="stylesheet" href="styles/bootstrap.css" type="text/css"/>
    <link rel="stylesheet" href="styles/main.css" type="text/css"/>
</head>
<body>

<div class="container">
    <h1>Employee List</h1>
    
    <c:if test="${messages != null}">
        <div class="alert alert-danger" role="alert">
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
            <c:forEach var="message" items="${messages}">
                <ul>
                    <li>${message}</li>
                </ul>
            </c:forEach>
        </div>
    </c:if>  

    <div class="col-md-6">
        <c:choose>
            <c:when test="${isUpdate == false}">
                <h2>Add new employee</h2>
            </c:when>
            <c:otherwise>
                <h2>Edit employee</h2>
            </c:otherwise>
        </c:choose>
        <form action="Controller" method="post">
            <input type="hidden" name="action" value="updateEmployee">
            <input type="hidden" name="employeeID" value="<c:out value='${employee.employeeID}' />">
            <div class="form-group row">
                <label for="first-name" class="col-md-3 col-form-label">First name:</label>
                <div class="col-md-9">
                    <input type="text" name="firstName" class="form-control" id="first-name" value="${employee.firstName}">
                </div>
            </div>
            <div class="form-group row">
                <label for="middle-name" class="col-md-3 col-form-label">Middle name:</label>
                <div class="col-md-9">
                    <input type="text" name="middleName" class="form-control" id="middle-name" value="${employee.middleName}">
                </div>
            </div>
            <div class="form-group row">
                <label for="last-name" class="col-md-3 col-form-label">Last name:</label>
                <div class="col-md-9">
                    <input type="text" name="lastName" class="form-control" id="last-name" value="${employee.lastName}">
                </div>
            </div>
            <div class="form-group row">
                <label for="employee-id" class="col-md-3 col-form-label">Employee ID:</label>
                <div class="col-md-9">
                    <input type="text" name="employeeID" class="form-control" id="employee-id" value="${employee.employeeID}">
                </div>
            </div>
            <div class="form-group row">
                <label for="date-of-birth" class="col-md-3 col-form-label">Date of Birth:</label>
                <div class="col-md-9">
                    <input type="date" name="birthDate" class="form-control" id="date-of-birth" value="${employee.birthDateFormatted}">
                </div>
            </div>             
            <div class="form-group row">
                <label for="hire-date" class="col-md-3 col-form-label">Hire Date:</label>
                <div class="col-md-9">
                    <input type="date" name="hireDate" class="form-control" id="last-name" value="${employee.hireDateFormatted}">
                </div>
            </div>
            <div class="form-group row">
                <div>
                    <c:choose>
                        <c:when test="${isUpdate == false}">
                            <input class="btn btn-primary" type="submit" value="Add Employee">
                        </c:when>
                        <c:otherwise>
                            <input class="btn btn-primary" type="submit" value="Update Employee">
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </form>
    </div> <!-- end col-md-6 -->

</div> <!-- end container -->
    
</body>
</html>