<%-- 
    Document   : index
    Created on : Jul 26, 2017, 11:18:14 AM
    Author     : da202057
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles/bootstrap.css" type="text/css"/>
        <link rel="stylesheet" href="styles/main.css" type="text/css"/>
        <title>Employee List</title>
    </head>
    <body>
        <div class="container">
            <h1>Employee List</h1>
            
            <h2>${message}</h2>
            
            <c:choose>
                <c:when test="${rowcount == 0}">
                    <p>Initial database values have already been added.</p>
                </c:when> 
                <c:when test="${rowcount == 1}">
                    <p>${rowcount} item was added to the database.</p>
                </c:when>
                <c:otherwise>
                    <p>${rowcount} items were added to the database.</p>
                </c:otherwise>
            </c:choose>
                    
            <c:if test="${searchDateFormatted != null}">
                <div class="alert alert-success" role="alert">
                    <p>Showing all employees hired on or ${searchCriteria} ${searchDateFormatted}.</p>
                    <p>Records found: ${listCount}</p>
                </div>
            </c:if>
            
            <c:if test="${messages != null}">
                <div class="alert alert-danger" role="alert">
                    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                    <!--<span>Error:</span>-->
                    <c:forEach var="message" items="${messages}">
                        <ul>
                            <li>${message}</li>
                        </ul>
                    </c:forEach>
                </div>
            </c:if>  
            
            <div class="row results">
                
                <div class="col-md-8">
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>First Name</th>
                                <th>Middle Initial</th>
                                <th>Last Name</th>
                                <th>Employee ID</th>
                                <th>Birth Date</th>
                                <th>Hire Date</th>
                                <th></th>
                                <!--<th></th>-->
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="employee" items="${employeeList}">
                                <tr>
                                    <td><c:out value="${employee.firstName}" /></td>
                                    <td><c:out value="${employee.middleName}" /></td>
                                    <td><c:out value="${employee.lastName}" /></td>
                                    <td><c:out value="${employee.employeeID}" /></td>
                                    <td><c:out value="${employee.birthDateFormatted}" /></td>
                                    <td><c:out value="${employee.hireDateFormatted}" /></td>
                                    <td>
                                        <form action="EmployeeEditServlet" method="post">
                                            <input type="hidden" name="action" value="editEmployee">
                                            <input type="hidden" name="employeeID" 
                                                   value="<c:out value='${employee.employeeID}' />">
                                            <input class="btn btn-primary btn-block" type="submit" value="Edit">
                                        </form>
                                    </td>
<!--                                    <td>
                                        <form action="EmployeeEditServlet" method="post">
                                            <input type="hidden" name="action" value="removeEmployee">
                                            <input type="hidden" name="employeeID" 
                                                   value="<c:out value='${employee.employeeID}' />">
                                            <input class="btn btn-danger btn-block" type="submit" value="Delete">
                                        </form>
                                    </td>-->
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <div class="col-md-4">
                    <form action="EmployeeListServlet" method="post">
                        <input type="hidden" name="action" value="searchRequest">
                        <div class="form-group">
                            <label for="select-hire-date">Search hire date</label>
                            <input type="date" name="searchDate" class="form-control" id="select-hire-date" value="<c:out value='${dateInputString}' />">
                        </div>
                        <div class="radio">
                            <label for="before-date">
                                <input type="radio" name="optionsDate" id="before-date" value="before" checked>Before selected date
                            </label>
                        </div>
                        <div class="radio">
                            <label for="after-date">
                                <input type="radio" name="optionsDate" id="after-date" value="after">After selected date
                            </label>
                        </div>

                        <input type="submit" value="Search">
                        <input type="reset">
                    </form>
                </div>
            </div> <!-- end row -->
            
            <form action="EmployeeListServlet" method="post">
                <input type="hidden" name="action" value="clearSearch">
                <input class="btn btn-primary btn-block" type="submit" value="Clear Search"
                    <c:if test="${hasSearched == false}">
                        disabled
                    </c:if> >
            </form>
            
        </div> <!-- end container -->
    </body>
</html>
