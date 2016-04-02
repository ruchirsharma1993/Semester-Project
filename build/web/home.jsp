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
        <%
          HttpSession cur_session = request.getSession();
        
         String user_name = (String)cur_session.getAttribute("uname");
        
         if(user_name==null)
         {
            System.out.println(user_name);
         
           %><jsp:forward page="index.html" /><%
          }
          String user_id = (String)cur_session.getAttribute("user_id");
        %>
	<div id="menu">
		<ul>
			<li class="current_page_item"><a href="#">Home</a></li>
			<li><a href="show_history.jsp">History</a></li>
                        <li><a href="#">About</a></li>
                        <li><a href="log_out">Log-Out</a></li>
                        
		</ul>
	</div>
	<!-- end #menu -->
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">Welcome, <%=user_name%></h2>
					</div>
					<div id="htmltagcloud"> 
                                        <span id="0" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=Business">Business</a></span>
                                         <span id="2" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=Health">Health</a></span> 
                                        <span id="3" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=Politics">Politics</a></span>
                                         <span id="4" class="wrd tagcloud8"><a href=show_latestnews.jsp?search_category=Science">Science</a></span> 
                                        <span id="5" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=Sports">Sports</a></span> 
                                        <span id="6" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=Technology">Technology</a></span>
                                        <span id="7" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=World">World</a></span> 
                                        <br><span id="1" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=Entertainment">Entertainment</a></span>
                                         
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
                                                                <input type="hidden" value="1" name="type"/>
                                                                <li><button class="button" type="submit"  name="search">Search</button></li>
                                                            </ul>
                                                          </form>
                                                </li>
                                                <h2>Advertisements</h2>
						<li>
						
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
