<!doctype html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>Reseptipankki</title>

<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link href='http://fonts.googleapis.com/css?family=PT+Sans'
	rel='stylesheet' type='text/css'>

<style type="text/css">

/*Set the background image to fit the screen.*/
body {
	font-family: 'PT Sans', sans-serif;
	background:
		url(http://www.niksula.hut.fi/~lsailara/background_contrast.jpg)
		no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}

.jumbotron {
	background-color: rgba(187, 242, 154, 1);
}

/*Search form*/
.form {
	clear: both;
}

.form-input {
	height: 34px;
	padding: 6px 12px;
	font-size: 14px;
	line-height: 1.42857;
	color: #555;
	width: 70%;
	border: 1px solid #CCC;
	border-radius: 4px;
	box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.075) inset;
	transition: border-color 0.15s ease-in-out 0s, box-shadow 0.15s
		ease-in-out 0s
}

/*Search button*/
.btn {
	height: 34px;
	margin-left: 5px;
	padding-top: 2px;
	padding-bottom: 2px;
	font-size: 20px;
}

/*Recipe preview*/
.panel {
	float: left;
}

.thumbnail {
	margin-left: auto;
	margin-right: auto;
	width: 250px;
}

@media all and (max-width: 640px) {
	h1 {
		margin: 10px 2px;
	}
	.jumbotron {
		margin: 2px;
	}
	.panel {
		margin: 1px 1px;
	}
}

@media all and (min-width: 640px) {
	body {
		height: 1300px;
	}
	h1 {
		margin: 20px 20px;
	}
	h2 {
		margin: 2px 0px;
	}
	.jumbotron {
		margin: 10px;
	}
	.form-input {
		width: 50%;
	}
	.panel {
		margin: 2px 5px;
	}
}
</style>
</head>

<body>

	<div class="container">
		<div class="jumbotron">
			<h1>Reseptipankki</h1>
			<form action="search" method="post">
				<input type="text" name="name" class="form-input"> <input
					type="submit" value="Etsi" class="btn" />
			</form>
		</div>
		<div>
			<c:if test="${!empty recipeList}">
				<tbody>
					<c:forEach items="${recipeList}" var="recipe">
						<div class="panel panel-default">
							<div class="panel-body">
								<h2>${recipe.name}</h2>
								<a href="get/${recipe.id}"> <img src="${recipe.imageUrl}"
									class="thumbnail" />
								</a>
							</div>
						</div>
					</c:forEach>
				</tbody>
			</c:if>
		</div>
	</div>

</body>
</html>
