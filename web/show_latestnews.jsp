<%-- 
    Document   : show_latestnews
    Created on : Apr 2, 2016, 11:26:20 AM
    Author     : ruchir-pc
--%>

<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.Searcher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@page import="java.sql.*"%>
<%@page import="com.LuceneConstants"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Search Results</title>
<link href='http://fonts.googleapis.com/css?family=Nova+Mono' rel='stylesheet' type='text/css' />
<link href="style\style.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
    <%
        String search_category = "";
         
        try
        {
            search_category = request.getParameter("search_category");
            if(search_category=="Technology")
                   search_category="Science And Technology";
        }
        catch(Exception e)
        {
            response.sendRedirect("index.html");
        }
        
        HttpSession cur_session = request.getSession();
        
        String user_name = (String)cur_session.getAttribute("uname");
        
        if(user_name==null)
        {
            System.out.println(user_name);
         
           %><jsp:forward page="index.html" /><%
        }
        String user_id = (String)cur_session.getAttribute("user_id");

     
    %>
<div id="wrapper">
	<div id="header-wrapper">
		<div id="header">
			<div id="logo">
				<h1><a href="#">Search Results</a></h1>
                                
			</div>
		</div>
	</div>
	<!-- end #header -->
	<div id="menu">
		<ul>
			<li><a href="home.jsp">Home</a></li>
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
                                     <h2> Latest Results for: <%=search_category %></h2> 
				<%try
                                {
                                    String bing_url = "https://bingapis.azure-api.net/api/v5/news?category=" + search_category +"&mkt=en-us";
                                    //String bing_url = "https://bingapis.azure-api.net/api/v5/news?category=sports&mkt=en-us";
                                    URL obj = new URL(bing_url);
                                    HttpURLConnection con = (HttpURLConnection) obj.openConnection();
                                    con.setRequestMethod("GET");
                                    con.setRequestProperty("User-Agent", "Mozilla/5.0");
                                    con.setRequestProperty("Host", "bingapis.azure-api.net");
                                    con.setRequestProperty("Ocp-Apim-Subscription-Key","d4333a2bf2404242a07e3e2ee230586a");
                                    //con.setRequestProperty("X-Search-ClientIP", "999.999.999.999");    
                                            
                                    int responseCode = con.getResponseCode();
                                    System.out.println("GET Response Code :: " + responseCode);
                                    if (responseCode == HttpURLConnection.HTTP_OK)
                                    { // success
                                        BufferedReader in = new BufferedReader(new InputStreamReader(
                                                con.getInputStream()));
                                        String inputLine;
                                        StringBuffer response_bing = new StringBuffer();

                                        while ((inputLine = in.readLine()) != null) 
                                        {
                                            System.out.println("Got: "+inputLine);
                                            response_bing.append(inputLine);
                                        }
                                        in.close();

                                        // print result
                                        System.out.println("res: "+ response_bing.toString());
                                        
                                        
                                        
                                         final JSONObject json = new JSONObject(response_bing.toString());
           
                                        final JSONArray results = json.getJSONArray("value");
                                        final int resultsLength = results.length();
                                        for (int i = 0; i < resultsLength; i++) 
                                        {
                                            final JSONObject aResult = results.getJSONObject(i);
                                            String news_title=aResult.get("name").toString();
                                            String news_category = search_category;
                                            String news_url = aResult.get("url").toString();
                                            String news_desc = aResult.get("description").toString();
                                                
                                               
                                           
                                  %>
                                    <div class="post">
						<h2 class="title"><a href="#"><%= news_title %></a></h2>
                                                <p class="meta">Category <%= news_category%>
							&nbsp;&bull;&nbsp;  
                                                        <a href="<%= news_url%>" class="permalink">Complete Story</a></p>
						<div class="entry">
							<p><%= news_desc%></p>
						</div>
					</div>
					
					<div style="clear: both;">&nbsp;</div>
				
                                <%
                                      //System.out.println("File: " + doc.get(LuceneConstants.FILE_PATH));
                                     
                                     
                                   }
                                         
                                    } else 
                                    {
                                        System.out.println("GET request not worked, System Offline");
                                    }
                                    
                                   
                        %>
                                </div>
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
                                
					<h2>ADVERTISEMENT</h2>      
                            
                            </div>
                                <%
                                  
                                }
                                catch(Exception e)
                                {
                                    System.out.println("Exception Overall: " + e);
                                    e.printStackTrace();
                                }
                                                
                                                %>
				
				<!-- end #sidebar -->
				<div style="clear: both;">&nbsp;</div>
			</div>
		</div>
	</div>
	<!-- end #page -->
</div>

</body>
</html>
