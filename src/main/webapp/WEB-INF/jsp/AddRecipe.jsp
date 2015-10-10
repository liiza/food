<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Recipe</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link href='http://fonts.googleapis.com/css?family=PT+Sans'
	rel='stylesheet' type='text/css'>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
body {
	font-family: 'PT Sans', sans-serif;
}

h3 {
	margin-top: 2px;
}

.image_form {
	float: left;
}

.form {
	float: left;
}

.form-input {
	height: 34px;
	padding: 6px 12px;
	font-size: 14px;
	line-height: 1.42857;
	color: #555;
	width: 50%;
	border: 1px solid #CCC;
	border-radius: 4px;
	box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.075) inset;
	transition: border-color 0.15s ease-in-out 0s, box-shadow 0.15s
		ease-in-out 0s
}

td {
	padding-top: 2px;
	padding-right: 5px;
}

img {
	padding: 5px;
}
</style>
<script>
	function uploadtoS3() {
		var files = document.getElementById("myFile").files;
		var file = files[0];
		var type = file.type;
		var name = file.name;

		// Send ajax call to server to sign the file.
		$
				.ajax({
					type : "POST",
					url : "signS3",
					data : {
						"type" : type,
						"name" : name
					},
					mimeType : "text/plain; charset=x-user-defined"
				})
				.done(
						function(data) {
							// Set the waiting gif
							$("#loadigimage").show();
							$("#loadingimage")
									.attr("src",
											"http://www.niksula.hut.fi/~lsailara/ajax-loader.gif");

							var response = JSON.parse(data);
							var url = response["signed_request"];
							var public_url = response["url"];

							console.log("Signed request " + url);
							var oReq = new XMLHttpRequest();
							oReq.onreadystatechange = function() {
								if (this.readyState == 4 && this.status == 200) {
									$("#loadingimage").hide();
									$("#image").attr("src", public_url);
									// Set the preview image
									$("#image_url_field").val(public_url);
								} else if (this.readyState == 4
										&& this.status != 200) {
									console.log("Image loading failed");
								}
							}
							// Send request to url that containt the signature
							oReq.open("put", url, true);
							// Set headers
							oReq.setRequestHeader('Content-Type', file.type);
							oReq.setRequestHeader('x-amz-acl', 'public-read');
							oReq.send(file);
						});

	}
</script>
</head>

<body>
	<div class="container">
		<h2>Add Recipe</h2>
		<div class="form">
			<form:form method="post" action="add" commandName="recipe">
				<table>
					<tr>
						<td><form:label path="name">Recipe name</form:label></td>
						<td><form:input path="name" /></td>
					</tr>

					<tr>
						<td><form:label path="imageUrl">Image Url</form:label></td>
						<td><form:input id="image_url_field" path="imageUrl" /></td>
					</tr>
					<c:forEach var="i" begin="0" end="4">
						<tr>
							<td><form:label path="ingredients[${i}].name">Ingredient</form:label></td>
							<td><form:input path="ingredients[${i}].name" /></td>
						</tr>
						<tr>
							<td><form:label path="ingredients[${i}].amount">Amount</form:label></td>
							<td><form:input path="ingredients[${i}].amount" /></td>
						</tr>
						<tr>
							<td><form:label path="ingredients[${i}].metric">Metric</form:label></td>
							<td><form:input path="ingredients[${i}].metric" /></td>
						</tr>

					</c:forEach>


					<c:forEach var="i" begin="0" end="4">
						<tr>
							<td><form:label path="steps[${i}]">Step ${i}</form:label></td>
							<td><form:input path="steps[${i}]" /></td>
						</tr>
					</c:forEach>

				</table>
				<input type="submit" value="Add Recipe" class="btn" />
			</form:form>
		</div>
		<div class="image_form">
			<h3>Upload image</h3>
			<p>
				Select one picture from your computer to be uploaded.<br /> The
				uploading is extremely slow. I'm sorry :(
			</p>
			<div>
				<input type="file" id="myFile">
				<button onclick="uploadtoS3()">Upload</button>
			</div>
			<img id="loadingimage" width="50px"></img> <img id="image"
				width="300px"></img>
		</div>
	</div>
</body>
</html>