<%-- 
    Document   : search_results
    Created on : Mar 7, 2016, 12:38:04 PM
    Author     : ruchir-pc
--%>
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

<%@page import="org.apache.lucene.analysis.standard.StandardAnalyzer"%>
<%@page import="org.apache.lucene.document.Document"%>
<%@page import="org.apache.lucene.index.CorruptIndexException"%>
<%@page import="org.apache.lucene.queryParser.ParseException"%>
<%@page import="org.apache.lucene.queryParser.QueryParser"%>
<%@page import="org.apache.lucene.search.IndexSearcher"%>
<%@page import="org.apache.lucene.search.Query"%>
<%@page import="org.apache.lucene.search.ScoreDoc"%>
<%@page import="org.apache.lucene.search.TopDocs"%>
<%@page import="org.apache.lucene.store.Directory"%>
<%@page import="org.apache.lucene.store.FSDirectory"%>
<%@page import=" org.apache.lucene.util.Version"%>

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
         String searchQuery = "";
         String q_type="";
        try
        {
            searchQuery = request.getParameter("query");
            q_type = request.getParameter("type");
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

      //Insert into DB if query type is 1
        if(q_type.equals("1"))
        {
          Class.forName("com.mysql.jdbc.Driver");
                String db_con = LuceneConstants.mysql_db_con;
                String mysql_user = LuceneConstants.mysql_user_name;
                String mysql_pass = LuceneConstants.mysql_user_pass;

                Connection con = DriverManager.getConnection(db_con, mysql_user, mysql_pass);
                String command="Insert into search_hist values(?,?,?)";
                PreparedStatement pstmt = con.prepareStatement(command);
                pstmt.setInt(1, Integer.parseInt(user_id));
                pstmt.setString(2, searchQuery);

                java.util.Date date= new java.util.Date();
                //System.out.println(new Timestamp(date.getTime()));
                pstmt.setTimestamp(3,new Timestamp(date.getTime()) );

                int i =pstmt.executeUpdate();
                if(i==1)
                {
                    System.out.println("Details entered in search_history");
                }
                else
                {
                    System.out.println("Insertion in databse failed. Redirected to homepage");
                    %>
                               <script type=\"text/javascript\">
                                        alert('Operation Aborted. Database Issue')
                                        location='home.html'
                               </script>
                        <% 
                }

        }
      
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
                                    <!-- <h2> Results for: <%=searchQuery %></h2> -->
				<%try
                                {
                                    String ad_dataDir = LuceneConstants.ad_dataDir;
                                    String news_dataDir = LuceneConstants.news_dataDir;
                                    
                                    String news_indexDir = LuceneConstants.news_indexDir; 
                                    String ad_indexDir = LuceneConstants.ad_indexDir;
                                                   
                                    Searcher search_news;
                                    Searcher search_ad;
                                    
                                    HashMap<String, Boolean> uniqueNews = new HashMap<String, Boolean>();
                                    
                                    search_news = new Searcher(news_indexDir, false);
                                    search_ad = new Searcher(ad_indexDir, true);
                                    
                                    long startTime = System.currentTimeMillis();
                                    TopDocs hits = search_news.search(searchQuery);
                                    long endTime = System.currentTimeMillis();
                                    
                                    System.out.println(hits.totalHits + " documents found. Time : " +
                                    (endTime - startTime) + " ms.");
                                    
                                    int news_items = 0;
                                    for(ScoreDoc scoreDoc : hits.scoreDocs) 
                                    {
                                            Document doc = search_news.getDocument(scoreDoc);
                                            
                                            String indexed_path = doc.get(LuceneConstants.FILE_PATH);
                                            System.out.println("Path: "+indexed_path);
                                            
                                            File f = new File(indexed_path);
                                           
                                           
                                            String file_name = f.getName();
                                            String path = news_dataDir + "\\" + file_name;
                                            
                                            BufferedReader br = new BufferedReader(new FileReader(path));
                                            String news_title="", news_desc="", news_url="", news_category="";
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
                                    if(news_items == 10)
                                        break;
                                    }
                                    search_news.close();

                                    TopDocs hits_ad = search_ad.search(searchQuery);
                                    System.out.println("Advertisement found: " + hits_ad.totalHits );
                                   
                                    ArrayList<String> ad_data = new ArrayList<String>();
                                    try
                                    {
                                        for(ScoreDoc scoreDoc : hits_ad.scoreDocs) 
                                        {
                                                Document doc = search_ad.getDocument(scoreDoc);
                                                String indexed_path = doc.get(LuceneConstants.FILE_PATH);
                                                
                                                File f = new File(indexed_path);
                                                String file_name = f.getName();
                                                
                                                String path = ad_dataDir + "\\" + file_name;
                                                BufferedReader br = new BufferedReader(new FileReader(path));

                                               

                                                String read = br.readLine();

                                                while(read!=null)
                                                {
                                                    read=br.readLine();
                                                    ad_data.add(read); 
                                                    
                                                }
                                                 br.close();
                                        }
                                      long seed = System.nanoTime();
                                      Collections.shuffle(ad_data, new Random(seed));
                                     
                                    }
                                    catch(Exception e)
                                    {
                                        System.out.println("Exception in processing news" + e.getLocalizedMessage());
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
                            <%
                                    int val = ad_data.size();
                                    //if(val>10)
                                            //val=10;
                                    int cnt = 0;
                                    for(int j=0;j<val;)
                                    {
                                        System.out.println(ad_data.get(j));
                                        if(ad_data.get(j) == null)
                                        {
                                            j++;
                                            continue;
                                        }
                                        String spl[] = ad_data.get(j).split(",");
                                        String title = spl[0].toUpperCase();
                                       
                                        String url = spl[1];
                                        String desc = spl[2];
                                        j++;
                                        cnt++;
                                        if(cnt == 10)
                                            break;
                            %>
                                  <li>
					<ul>
                                            <b><li><a href="<%= url%>"><%=title %></a></li></b>
                                           
                                            <li><%=desc %></li>
                                                            
					</ul>
				   </li>
						
				    <%
                                    }
                                    %>
                                    </ul>
                                    
                            </div>
                                <%
                                    search_ad.close();
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