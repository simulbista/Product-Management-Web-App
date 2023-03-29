<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Records</title>
<link rel="stylesheet" href="./mycss.css">
</head>
<body>
	<div class="input">
	<h2>INSERT RECORDS</h2>
		<form method="post">
			Product No.: <input type="text" name="pno"/><br>
			Product Name: <input type="text" name="pname"/><br>
			Product Type:
			<div>
			<label><input type="radio" name="ptype" value="home-app"> Home Appliance</label>
			<label><input type="radio" name="ptype" value="comp-hard"> Computer Hardware</label>
			<label><input type="radio" name="ptype" value="game-con"> Game Console</label>
			<label><input type="radio" name="ptype" value="cloth"> Clothing</label>
			</div><br>
			Manufacturer:
			<select name="manu">
			  <option value="lg" selected>LG</option>
			  <option value="sony">Sony</option>
			  <option value="pana">Panasonic</option>
			</select>
			<br>
			Price: <input type="text" name="price"/>
			<br>
			Weight: <input type="text" name="weight"/>
			<br>
			<button type="submit">Add Product</button>
			<br>
			<button type="reset">Clear</button>
		</form>
	</div>

	<!-- loading driver and database connection set up -->
		<sql:setDataSource var="mydb" driver="com.mysql.cj.jdbc.Driver"
			url="jdbc:mysql://localhost:3306/A3" user="root"
			password="root" />
			
		<!-- execute the insert sql if the add product button is entered and the price is between 100 and 900-->
		<c:if test="${not empty param.pno && Double.parseDouble(param.price) ge 100 && Double.parseDouble(param.price) le 900}">
			<!-- inserting data into the table -->	
			<sql:update dataSource = "${mydb}" var="count">
			INSERT INTO PRODUCT (ProductNo, ProductName, ProductType, Manufacturer, Price, Weight) VALUES (?, ?, ?, ?, ?, ?)
			  <sql:param value="${param.pno}" />
			  <sql:param value="${param.pname}" />
			  <sql:param value="${paramValues.ptype[0]}" />
			  <sql:param value="${paramValues.manu[0]}" />
			  <sql:param value="${param.price}" />
			  <sql:param value="${param.weight}" />
		  	</sql:update>
  		</c:if>
  		
  		<!--display validation error if price is not between $100 and $900 -->
  		<div class="price-validation">
  		<c:if test="${not empty param.price && param.price le 100.00 || param.price ge 900.00}">
  			<div class="validation-error">Price needs to be between $100 and $900!</div>
  		</c:if>
  		</div>
  		
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