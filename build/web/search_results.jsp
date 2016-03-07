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
      String searchQuery = request.getParameter("query");
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
                                    <!-- <h2> Results for: <%=searchQuery %></h2> -->
				<%try
                                {
                                    //String ad_dataDir = "E:\\work\\IIIT\\Semester_Project_Related\\index\\ad_documents";
                                    //String news_dataDir = "E:\\work\\IIIT\\Semester_Project_Related\\index\\news_articles";
                                    
                                    //String news_indexDir = "E:\\work\\IIIT\\Semester_Project_Related\\index\\news_index";
                                    //String ad_indexDir = "E:\\work\\IIIT\\Semester_Project_Related\\index\\ads_index";
                                    
                                    String ad_dataDir = "G:\\Assignments\\Semester Project\\ads\\ad_documents";
                                    String news_dataDir = "G:\\Assignments\\Semester Project\\news\\news_articles";
                                    
                                    String news_indexDir = "G:\\Assignments\\Semester Project\\news\\index";
                                    String ad_indexDir = "G:\\Assignments\\Semester Project\\ads\\index";
                                                   
                                    Searcher search_news;
                                    Searcher search_ad;
                                    
                                    HashMap<String, Boolean> uniqueNews = new HashMap<String, Boolean>();
                                    
                                    search_news = new Searcher(news_indexDir);
                                    search_ad = new Searcher(ad_indexDir);
                                    
                                    long startTime = System.currentTimeMillis();
                                    TopDocs hits = search_news.search(searchQuery);
                                    long endTime = System.currentTimeMillis();
                                    
                                    System.out.println(hits.totalHits + " documents found. Time : " +
                                    (endTime - startTime) + " ms.");

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
                                                news_url = br.readLine();
                                                
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
                                        System.out.println("Exception in processing news"+e.getLocalizedMessage());
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
                                                                <li><button class="button" type="submit"  name="search">Search</button></li>
                                                            </ul>
                                                          </form>
                                </li>
                                
					<h2>ADVERTISEMENT</h2>      
                            <%
                                    int val = ad_data.size();
                                    if(val>10)
                                            val=10;
                                    for(int j=0;j<val;j++)
                                    {
                                        String spl[] = ad_data.get(j).split(",");
                                        String title = spl[0].toUpperCase();
                                       
                                        String url = spl[1];
                                        String desc = spl[2];
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
                                    System.out.println("Exception: "+e+e.getLocalizedMessage());
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