
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Manage Courses</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/angular-material/1.1.10/angular-material.min.css">
</head>
<body>
	<%-- Course Add/Edit logic --%>
	<c:if test="${requestScope.error ne null}">
		<strong style="color: red;"><c:out
				value="${requestScope.error}"></c:out></strong>
	</c:if>
	<c:if test="${requestScope.success ne null}">
		<strong style="color: green;"><c:out
				value="${requestScope.success}"></c:out></strong>
	</c:if>
	<c:url value="/addCourse" var="addURL"></c:url>
	<c:url value="/editCourse" var="editURL"></c:url>
	<c:url value="courseScheduler" var="schedulerURL"></c:url>

	<%-- Edit Request --%>
	<c:if test="${requestScope.course ne null}">
		<form action='<c:out value="${editURL}"></c:out>' method="post">
			Course ID: <input type="text" value="${requestScope.course.id}"
				readonly="readonly" name="id">
				<br> Course Name: <input
				type="text" value="${requestScope.course.name}" name="name">
				<br> Course Location: <input
				type="text" value="${requestScope.course.location}" name="location">
				<br> <input type="submit" value="Edit Course">
		</form>
	</c:if>

	<%-- Add Request --%>
	<c:if test="${requestScope.course eq null}">
		<form action='<c:out value="${addURL}"></c:out>' method="post">
			Course Name: <input type="text" name="name"> 
			<br> Course Location: <input type="text" name="location">
			<br> <input type="submit" value="Add Course">
		</form>
	</c:if>	
	
	<form action="getCourses">
		<input type="submit" value="View Course Scheduler"/>
	</form>
	<br> 
	<%-- Courses List Logic --%>
	<c:if test="${not empty requestScope.courses}">
		<table>
			<tbody>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>
				<c:forEach items="${requestScope.courses}" var="course">
					<c:url value="/editCourse" var="editURL">
						<c:param name="id" value="${course.id}"></c:param>
					</c:url>
					<c:url value="/deleteCourse" var="deleteURL">
						<c:param name="id" value="${course.id}"></c:param>
					</c:url>
					<tr>
						<td><c:out value="${course.id}"></c:out></td>
						<td><c:out value="${person.location}"></c:out></td>
						<td><a
							href='<c:out value="${editURL}" escapeXml="true"></c:out>'>Edit</a></td>
						<td><a
							href='<c:out value="${deleteURL}" escapeXml="true"></c:out>'>Delete</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	
	<br/>
	<br/>
	<br/>
	<%-- <!-- USERS -->
	<c:url value="/addUser" var="addUserURL"></c:url>
	<c:url value="/editUser" var="editUserURL"></c:url>
	<c:if test="${requestScope.user eq null}">
		<form action='<c:out value="${addUserURL}"></c:out>' method="post">
			Name: <input type="text" name="name"> 
			<br> Courses (comma separated): <input type="text" name="courses">
			<br> Date of Birth: <input type="text" name="dateOfBirth">
			<br> <input type="submit" value="Add User">
		</form>
	</c:if> --%>
	
		<a href="enrollCourse">Course Enroll</a>

<%-- 	<a href="<c:url value="enrollCourse.jsp" var="enrollURL"></c:url>"><button>Course Enroll</button></a> --%>
	
</body>
</html>
