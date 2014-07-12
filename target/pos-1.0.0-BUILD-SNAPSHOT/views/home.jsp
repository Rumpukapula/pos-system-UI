<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en" ng-app="posApp">
  	<head>
	    <meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <meta name="description" content="CmBurger">
	    <meta name="author" content="Lauri Rummukainen">
	    <link rel="shortcut icon" href="">
	
	    <title>Point of Sale System</title>
	 
	    <!-- Bootstrap core CSS -->
	    <link href="resources/css/bootstrap-theme-united.css" rel="stylesheet">
	
	    <!-- Custom styles for this template -->
	   	<link href="resources/css/preorder.css" rel="stylesheet">
	
	    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	    <!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
			<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->
	</head>

	<body>
		<div ng-view></div>

		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.19/angular.js"></script>
		<script src="resources/js/angular/angular-route.min.js"></script>
		<script src="resources/js/angular/ui-bootstrap-tpls-0.11.0.js"></script>
		<script src="resources/js/app.js"></script>
		<script src="resources/js/controllers.js"></script>
	</body>
</html>