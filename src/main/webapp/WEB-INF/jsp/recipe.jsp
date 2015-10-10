<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${recipe.name}</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link href='http://fonts.googleapis.com/css?family=PT+Sans'
	rel='stylesheet' type='text/css'>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>

<style type="text/css">
body {
	font-family: 'PT Sans', sans-serif;
	background:
		url(http://www.niksula.hut.fi/~lsailara/background_contrast.jpg)
		no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
	height: 1300px;
}

.container {
	background-color: #FFF;
	margin: 5px;
	margin-left: auto;
	margin-right: auto;
}

#ingredients,#steps {
	float: left;
	font-size: 18px;
}
td {
	padding-left: 2px;
}
.name {
	padding-left: 50px;
}

@media all and (max-width: 640px) {
	.image {
		width: 225px;
		float: left;
		margin-bottom: 15px;
	}

	#steps {
		width: 200px;
		padding-left: 10px;
		margin-bottom: 30px
	}
	#ingredients {
		padding-left: 10px;
		width: 200px;
		margin-bottom: 10px
	}

	.container {
		width: 85%;
		border-radius: 4px;
	}
}

@media all and (min-width: 640px) {
	body {
		height: 1300px;
	}

	.image {
		width: 350px;
		float: left;
		margin-bottom: 15px;
	}

	#steps {
		width: 250px;
		margin-left: 30px;
		padding-left: 20px;
	}
	#ingredients {
		padding-left: 30px;
		width: 250px;
		margin-bottom: 10px
	}

	.container {
		width: 75%;
		border-radius: 4px;
	}
	.unchecked:before {
		content:
			url("http://www.niksula.hut.fi/~lsailara/1416713855_unchecked_checkbox_minimized.png");
	}
	.checked:before {
		content:
			url("http://www.niksula.hut.fi/~lsailara/1416713864_checked_checkbox_minimized.png");
	}
	span {
		top: -7px;
		position: relative;
		padding-left: 7px;
	}
}
@media all and (min-width: 1400px) {
	body {
		height: 1300px;
	}
	.image {
		width: 350px;
		float: left;
		margin-bottom: 15px;
	}
	#steps {
		width: 350px;
		margin-left: 30px;
		padding-left: 20px;
	}
	#ingredients {
		padding-left: 30px;
		width: 350px;
		margin-bottom: 10px
	}
	
	.container {
		width: 75%;
		border-radius: 4px;
	}

	.unchecked:before {
		content:
			url("http://www.niksula.hut.fi/~lsailara/1416713855_unchecked_checkbox_minimized.png");
	}
	.checked:before {
		content:
			url("http://www.niksula.hut.fi/~lsailara/1416713864_checked_checkbox_minimized.png");
	}
	span {
		top: -7px;
		position: relative;
		padding-left: 7px;
	}
}
</style>
<script>
	// Preload the checked-checkbox image to prevent the dealy caused by loading when checking checkbox the first time.
	function preloader() {
		var unchecked_image = new Image();
		unchecked_image.src = "http://www.niksula.hut.fi/~lsailara/1416713864_checked_checkbox_minimized.png";
	}
	// User can check and uncheck the image	
	$(document).ready(function() {
		$(".unchecked").click(function() {
			$(this).toggleClass("checked");
		});
	});
</script>
</head>
<body onLoad="javascript:preloader()">
	<div class="container">
		<h1>${recipe.name}</h1>
		<img src="${recipe.imageUrl}" class="image" />
		<div id="ingredients">
			<table class="members">
				<c:forEach var="row" items="${recipe.ingredients}">
					<tr>
						<td>${row.amount}</td>
						<td>${row.metric}</td>
						<td class="name">${row.name}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div id="steps">
			<table>
				<c:forEach var="row" items="${recipe.steps}">
					<tr>
						<td class="unchecked"><span>${row}</span></td>
					</tr>
				</c:forEach>
			</table>

		</div>
	</div>
</body>
</html>