<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Product</title>
<link rel="stylesheet" href="./mycss.css">
</head>
<body>
	<div class="input">
	<h2>ADD PRODUCT</h2>
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
	
	<div class="output">
		<div>The following information is received:</div>
		<div>Product No. is <%= request.getParameter("pno")!=null?request.getParameter("pno"):"" %></div>
		<div>Product Name is <%= request.getParameter("pname")!=null?request.getParameter("pname"):"" %></div>
		<% try{ %>
		<div>Product Type is : <%= request.getParameterValues("ptype")!=null?request.getParameterValues("ptype")[0]:"" %></div>
		<div>Product Manufacturer is : <%= request.getParameterValues("manu")!=null?request.getParameterValues("manu")[0]:"" %></div>
		<% }catch(Exception e){e.printStackTrace();} %>
		
		<div>Price is <%= request.getParameter("price")!=null?request.getParameter("price"):"" %></div>
		<div>Weight is <%= request.getParameter("weight")!=null?request.getParameter("weight"):"" %></div>
	</div>
	
</body>
</html>