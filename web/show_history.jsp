<%-- 
    Document   : home
    Created on : Mar 7, 2016, 12:24:09 PM
    Author     : ruchir-pc
--%>

<%@page import="java.sql.*"%>
<%@page import="com.LuceneConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>View History</title>
<link href='http://fonts.googleapis.com/css?family=Nova+Mono' rel='stylesheet' type='text/css' />
<link href="style\style.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
<div id="wrapper">
	<div id="header-wrapper">
		<div id="header">
			<div id="logo">
				<h1><a href="#">VIEW HISTORY</a></h1>
			</div>
		</div>
	</div>
	<!-- end #header -->
	<div id="menu">
		<ul>
			<li ><a href="home.jsp">Home</a></li>
			<li class="current_page_item"><a href="show_history.jsp">History</a></li>
                        <li><a href="#">About</a></li>
                        <li><a href="log_out">Log-Out</a></li>
                        
		</ul>
	</div>
	<!-- end #menu -->
         <%
        
        HttpSession cur_session = request.getSession();
       
        String user_name = (String)cur_session.getAttribute("uname");
        
        System.out.println("Username is " + user_name);
        if(user_name==null)
        {
            System.out.println("Username is null");
         
           %><jsp:forward page="index.html" /><%
        }
            String user_id = (String)cur_session.getAttribute("user_id");
        
             Class.forName("com.mysql.jdbc.Driver");
                  
             String db_con = LuceneConstants.mysql_db_con;
             String mysql_user = LuceneConstants.mysql_user_name;
             String mysql_pass = LuceneConstants.mysql_user_pass;
                  
             Connection con = DriverManager.getConnection(db_con, mysql_user, mysql_pass);
             PreparedStatement ps=con.prepareStatement("select * from search_hist where user_id=? order by time desc");
             ps.setInt(1, Integer.parseInt(user_id));
             ResultSet rs=ps.executeQuery();
            %>
    
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">SEARCH HISTORY</h2>
                                                   <table border="1" width=600">
                                                    <tr>
                                                    <th><b><u>Query</u></b></th>
                                                    <th><b><u>TimeStamp</u></b></th>
                                                    <th>*</th>
                                                    </tr>
                                                    <%
                                                    while(rs.next())
                                                    { %>
                                                       <tr> 
                                                       <td><%=rs.getString("search_text") %></td>
                                                       <td><%= rs.getTimestamp("time") %></td>
                                                       <td><button><a href="search_results.jsp?type=2&query=<%=rs.getString("search_text")%>">View Results</a></button></td> 
                                                       </tr>
                                                   <% 
                                                    }
                                                   %>
                                                   </table>
                                                    
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
