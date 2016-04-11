<%-- 
    Document   : result_hindi
    Created on : Apr 11, 2016, 11:27:26 PM
    Author     : ruchir-pc
--%>

<%@page import="java.util.Comparator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
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
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">

<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Search Results</title>
<link href='http://fonts.googleapis.com/css?family=Nova+Mono' rel='stylesheet' type='text/css' />
<link href="style\style.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
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
                                    
				<%try
                                {
                                    String hindi_dataset = LuceneConstants.news_hindidataDir;
                                    int[] arr= {1,2,3,4,5,6,7,8,9};
                                    
                                    String news_title="", news_desc="", news_url="", news_category="", news_buzzwords="";

                    
                                    for(int i=0;i<0;i++)
                                    {
                                        String file_name = "news_" + arr[i];
                                        String path = hindi_dataset + "\\" + file_name;
                                    
                                        BufferedReader br = new BufferedReader(new FileReader(path));
                                        br.readLine();
                                        news_title = br.readLine();

                                       
                                        news_url = br.readLine().replace(" amp;", "&").replace("amp;","");
                                        news_desc = br.readLine();
                                        news_category = br.readLine();

                                        

                                  %>
                                    <div class="post">
						<h2 class="title" id="hindi"><a href="#"><%= news_title %></a></h2>
                                                <p class="meta">Category <%= news_category%>
							&nbsp;&bull;&nbsp;  
                                                        <a href="<%= news_url%>" class="permalink">Complete Story</a></p>
						<div class="entry">
							<p><%= news_desc%></p>
						</div>
					</div>
					
					<div style="clear: both;">&nbsp;</div>
				
                                <%
                                    }
                          }catch(Exception e)
                            {
                                System.out.println("Exception in reading hindi data" + e);
                            }
                        %>
                                
                                 <div class="post">
						<h2 class="title" ><a href="#">पैसा फंड (AP) नवीनतम सप्ताह में गिर गया</a></h2>
                                                <p class="meta">Category Business
							&nbsp;&bull;&nbsp;  
                                                        <a href="http://us.rd.yahoo.com/dailynews/rss/business/*http://story.news.yahoo.com/news?tmpl=story2 u=/ap/20040812/ap_on_bi_ge/money_funds
" class="permalink">Complete Story</a></p>
						<div class="entry">
							<p>AP - देश के खुदरा पैसे की संपत्ति बाजार म्युचुअल फंड फेल #36 द्वारा; #36 करने के लिए नवीनतम सप्ताह में 1.17 अरब; 849.98 खरब, निवेश कंपनी संस्थान गुरुवार ने कहा।
</p>
						</div>
					</div>
					
					<div style="clear: both;">&nbsp;</div>
                                
                                
                                      <div class="post">
						<h2 class="title" ><a href="#">विद्रोह इराक तेल निर्यात आधी रखता है</a></h2>
                                                <p class="meta">Category Business
							&nbsp;&bull;&nbsp;  
                                                        <a href="http://www.reuters.com/newsArticle.jhtml?type=businessNews storyID=5977774 src=rss/businessNews section=news" class="permalink">Complete Story</a></p>
						<div class="entry">
							<p> बगदाद (रायटर) - इराक के तेल के रूप में एक मुख्य पाइपलाइन देश के टर्मिनलों की खाड़ी में खिला के पुन: खोलने एक अमेरिका विरोधी विद्रोह के कारण अस्थिरता रोका निर्यात अभी भी आधा अपने सामान्य दर पर रविवार चल रहे थे।
</p>
						</div>
					</div>
					
					<div style="clear: both;">&nbsp;</div>  

                                         <div class="post">
						<h2 class="title" ><a href="#"> उपभोक्ता कीमतों में गिरावट, उद्योग आउटपुट अप</a></h2>
                                                <p class="meta">Category US
							&nbsp;&bull;&nbsp;  
                                                        <a href="http://www.reuters.com/newsArticle.jhtml?type=domesticNews storyID=5999319 src=rss/domesticNews section=news" class="permalink">Complete Story</a></p>
						<div class="entry">
							<p> वॉशिंगटन (रायटर) - अमेरिकी उपभोक्ता मूल्य एक तेज के रूप में आठ महीने में पहली बार के लिए जुलाई में गिरा चला उलट, पेट्रोल की कीमत में मंगलवार को एक रिपोर्ट अमेरिकी फेडरल रिजर्व की क्रमिक ब्याज दर एक योजना के लिए छड़ी कर सकते हैं सुझाव में कहा कि सरकार से उगता है।</p>
						</div>
					</div>
					
					<div style="clear: both;">&nbsp;</div>  
                                        
                                         <div class="post">
						<h2 class="title" ><a href="#">सामग्री रिटर्न लाभ के लिए आवेदन किया</a></h2>
                                                <p class="meta">Category Business
							&nbsp;&bull;&nbsp;  
                                                        <a href="http://www.reuters.com/newsArticle.jhtml?type=businessNews storyID=5999436 src=rss/businessNews section=news" class="permalink">Complete Story</a></p>
						<div class="entry">
							<p>, मंगलवार को चिप बनाने के उपकरण, का सबसे बड़ा निर्माता ने कहा कि स्वस्थ नए सेमीकंडक्टर कारखानों पर खर्च राजस्व 100 प्रतिशत से अधिक को धक्का दिया और यह करने के लिए एक तिमाही लाभ दिए गए।</p>
						</div>
					</div>
					
					<div style="clear: both;">&nbsp;</div>  
                                        
                                         <div class="post">
						<h2 class="title" ><a href="#">इलिनोइस में मदद करता है निवासियों आयात दवाओं का सेवन</a></h2>
                                                <p class="meta">Category Health
							&nbsp;&bull;&nbsp;  
                                                        <a href="http://www.reuters.com/newsArticle.jhtml?type=healthNews storyID=5999232 src=rss/healthNews section=news" class="permalink">Complete Story</a></p>
						<div class="entry">
							<p> शिकागो (रायटर) - इलिनोइस निवासियों जल्द ही आयातित औषधों, को अमेरिकी नियामकों आपत्ति sidestepping gov. रॉड है Blagojevich मंगलवार को कहा कि कम लागत वाली दवाओं से कनाडा, यूनाइटेड किंगडम और आयरलैंड, खरीदने के लिए सक्षम हो जाएगा।</p>
						</div>
					</div>
					
					<div style="clear: both;">&nbsp;</div>  
                                
                                
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

</body>
</html>