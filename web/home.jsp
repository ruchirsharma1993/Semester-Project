<%-- 
    Document   : home
    Created on : Mar 7, 2016, 12:24:09 PM
    Author     : ruchir-pc
--%>

<%@page import="java.io.FileReader"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.lucene.document.Document"%>
<%@page import="org.apache.lucene.search.ScoreDoc"%>
<%@page import="org.apache.lucene.search.TopDocs"%>
<%@page import="com.Searcher"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.LuceneConstants"%>
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
			<li><a href="show_history.jsp">History</a></li>
                        <li><a href="#">About</a></li>
                        <li><a href="log_out">Log-Out</a></li>
                        
		</ul>
	</div>
        <%
         HttpSession cur_session = request.getSession();
        
         String user_name = (String)cur_session.getAttribute("uname");
        
         if(user_name==null)
         {
            System.out.println(user_name);
         
           %><jsp:forward page="index.html" />
        <%}
            String user_id = (String)cur_session.getAttribute("user_id");
           %>
	<!-- end #menu -->
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">Welcome, <%=user_name%></h2>
					</div>
					<div id="htmltagcloud"> 
                                        <span id="0" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=Business">Business</a> </span>&nbsp;
                                        <span id="1" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=Politics">Politics</a></span>
                                        <br><span id="2" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=Entertainment">Entertainment</a> </span>
                                         <span id="7" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=World">World</a></span> 
                                         <br><br><span id="3" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=Health"> Health</a> </span> 
                                        <span id="6" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=Technology">Technology</a> </span>
                                       <br><br><span id="4" class="wrd tagcloud8"><a href=show_latestnews.jsp?search_category=Science">Science</a> </span> 
                                        <span id="5" class="wrd tagcloud8"><a href="show_latestnews.jsp?search_category=Sports">Sports</a></span> 
                                        <br><br>
                                         
                                        </div>
					
					<div style="clear: both;">&nbsp;</div>
                                        <h2 class="title">News Feed</h2>
        <%
          //Retrieve last search queries 
            Class.forName("com.mysql.jdbc.Driver");
            String db_con = LuceneConstants.mysql_db_con;
            String mysql_user = LuceneConstants.mysql_user_name;
            String mysql_pass = LuceneConstants.mysql_user_pass;
            Connection con = DriverManager.getConnection(db_con, mysql_user, mysql_pass);
            PreparedStatement ps=con.prepareStatement("select * from search_hist where user_id=? order by time desc");
            ps.setInt(1, Integer.parseInt(user_id));
            ResultSet rs=ps.executeQuery();
            
            //Retrieve first three search queries
            String s1="", s2 = "", s3="";
            if(rs.next())
                s1 = rs.getString("search_text");
            if(rs.next())
                s2 = rs.getString("search_text");
            if(rs.next())
                s3 = rs.getString("search_text");
            rs.close();

            String ad_dataDir = LuceneConstants.ad_dataDir;
            String news_dataDir = LuceneConstants.news_dataDir;
            
            String news_indexDir = LuceneConstants.news_indexDir;
            String ad_indexDir = LuceneConstants.ad_indexDir;
                                                   
            Searcher search_news;
            Searcher search_ad;
                                                   
            search_news = new Searcher(news_indexDir, false);
            TopDocs hits = search_news.search(s1);
            //TopDocs hits2 = search_news.search(s2);
            //TopDocs hits3 = search_news.search(s3);
            
            int news_items = 0;
            HashMap<String, Boolean> uniqueNews = new HashMap<String, Boolean>();
            for(ScoreDoc scoreDoc : hits.scoreDocs)
            {
                Document doc = search_news.getDocument(scoreDoc);
                String indexed_path = doc.get(LuceneConstants.FILE_PATH);

                System.out.println("Path: "+indexed_path);
                File f = new File(indexed_path);
                                           
                                           
                String file_name = f.getName();
                String path = news_dataDir + "\\" + file_name;
                BufferedReader br = new BufferedReader(new FileReader(path));
                                            
                String news_title="", news_desc="", news_url="", news_category="", news_buzzwords="";
                try
                {
                    br.readLine();
                    news_title = br.readLine();
                                                
                    if(uniqueNews.containsKey(news_title)) // check to ensure news does not repeat
                        continue;
                                                
                    uniqueNews.put(news_title, true);
                    news_url = br.readLine().replace(" amp;", "&").replace("amp;","");
                    news_desc = br.readLine();
                    news_category = br.readLine();
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
                                      br.close();
                                       }catch(Exception e)
                                            {
                                                System.out.println("Exception in reading news"+e);
                                            }
                                    news_items++;
                                    if(news_items == 8)
                                        break;
                                    }
                                    search_news.close();
                                                   

           
           %>

        %>
                        
                                </div>
                        
                        
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
                                                <!--<h2>Advertisements</h2>
						-->
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