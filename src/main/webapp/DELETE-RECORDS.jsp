<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Records</title>
<link rel="stylesheet" href="./mycss.css">
</head>
<body>
	<div class="input">
	<h2>DELETE RECORDS</h2>
		<form method="post">
			Enter Product No.: <input type="text" name="searchpno"/><br>
			<button type="submit">Delete the Product!</button>
		</form>
	</div>

	<!-- loading driver and database connection set up -->
		<sql:setDataSource var="mydb" driver="com.mysql.cj.jdbc.Driver"
			url="jdbc:mysql://localhost:3306/A3" user="root"
			password="root" />
		
		<!--  if the entered product no. exists in the database -->	

		<sql:query dataSource = "${mydb}" var="rs">
				select * from PRODUCT;
		</sql:query>	
		
		<!-- set the existFlag to false by default - i.e product with product no. doesn't exist -->
		<c:set var="existflag" value="false" />
		<!-- Delete records by product id - first check if searched product no. exists, then loop 
		through all the records in the db matching the entered product no., if matches delete that record -->
		<c:if test="${not empty param.searchpno}">
			<c:forEach var='row' items="${rs.rows}">
				<c:if test="${row['ProductNo'] == param.searchpno}">
					<sql:update dataSource = "${mydb}" var="count">
						delete from PRODUCT WHERE ProductNo=?;
						<sql:param value="${param.searchpno}" />
					</sql:update>
					<!-- set the existFlag to true since product id exists in the database -->
					<c:set var="existflag" value="true" />
					<div class="validation-success">Product ${row['ProductNo']} has been deleted from the database!</div>
				</c:if>
			</c:forEach>
		</c:if>
		
		<!-- if the product id doesn't exist in the database, display an error -->
		<c:if test="${not empty param.searchpno && !existflag}">
			<div class="validation-error">Product ${param.searchpno} doesn't exist in the database!</div>
		</c:if>
  		
  		<div class="db-result">
	  		<!-- display the records from the database -->
			<sql:query dataSource = "${mydb}" var="rs">
				select * from PRODUCT;
			</sql:query>
			
			<h3>PRODUCT INFORMATION:</h3>
			<table border='1'>
				<tr>
					<th>Product No.</th>
					<th>Product Name:</th>
					<th>Product Type:</th>
					<th>Manufacturer:</th>
					<th>Price:</th>
					<th>Weight:</th>
				</tr>
				<c:forEach var='row' items="${rs.rows}">
				<tr>
					<td>${row['ProductNo']}</td>
					<td>${row['ProductName']}</td>
					<td>${row['ProductType']}</td>
					<td>${row['Manufacturer']}</td>
					<td>${row['Price']}</td>
					<td>${row['Weight']}</td>
				</tr>
				</c:forEach>
			</table>
		</div>	
</body>
</html>