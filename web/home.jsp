<%-- 
    Document   : home
    Created on : Mar 7, 2016, 12:24:09 PM
    Author     : ruchir-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Home Page</title>
<link href='http://fonts.googleapis.com/css?family=Nova+Mono' rel='stylesheet' type='text/css' />
<link href="style\style.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
<div id="wrapper">
	<div id="header-wrapper">
		<div id="header">
			<div id="logo">
				<h1><a href="#">HOME</a></h1>
				
			</div>
		</div>
	</div>
	<!-- end #header -->
	<div id="menu">
		<ul>
			<li class="current_page_item"><a href="#">Home</a></li>
			   <li><a href="#">History</a></li>
                        <li><a href="#">About</a></li>
		</ul>
	</div>
	<!-- end #menu -->
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">Your Feed is Currently Empty</h2>
						
					</div>
					
					
					<div style="clear: both;">&nbsp;</div>
				</div>
				<!-- end #content -->
				<div id="sidebar">
					<ul>
						<li>
							<h2>SEARCH</h2>
							  <form action="search_results.jsp">
                                                            <ul>
                                                                <li><input type="text" value="" name="query" placeholder="Enter your query here" /></li>
                                                                <li><button class="button" type="submit"  name="search">Search</button></li>
                                                            </ul>
                                                          </form>
                                                </li>
                                                <h2>Advertisements</h2>
						<li>
							
						</li>
						<li>
							
						</li>
						<li>
							
						</li>
					</ul>
				</div>
				<!-- end #sidebar -->
				<div style="clear: both;">&nbsp;</div>
			</div>
		</div>
	</div>
	<!-- end #page -->
</div>
<div id="footer">
	<p></p>
</div>
<!-- end #footer -->
</body>
</html>