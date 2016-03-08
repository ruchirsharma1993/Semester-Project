/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

/**
 *
 * @author ruchir-pc
 */
public class LuceneConstants 
{
        public static final String CONTENTS = "contents";
	public static final String FILE_NAME = "filename";
	public static final String FILE_PATH = "filepath";
	public static final int MAX_SEARCH_NEWS = 50;
        public static final int MAX_SEARCH_ADS = 10;
        
        
        /*******************************************************************************************************************
               Constants for News, Ad Index and files, change as per configuration
        *******************************************************************************************************************/
        
        //Advertisement Dataset directory path
        public static final String ad_dataDir = "E:\\work\\IIIT\\Semester_Project_Related\\index\\ad_documents";
        
        //News Dataset Directory Path
        public static final String news_dataDir = "E:\\work\\IIIT\\Semester_Project_Related\\index\\news_articles";
        
        //News Index Directory path
        public static final String news_indexDir = "E:\\work\\IIIT\\Semester_Project_Related\\index\\news_index";
        
        //Advertisement Index directory path
        public static final String ad_indexDir = "E:\\work\\IIIT\\Semester_Project_Related\\index\\ads_index";
        
        
        /*******************************************************************************************************************
               Constants for MYSQL DB Connection
        *******************************************************************************************************************/
        
        //Update these strings as per your details
        public static final String mysql_db_name = "sem_proj";
        public static final String mysql_user_name = "ruchir";
        public static final String mysql_user_pass = "ruchir";
        public static final String mysql_port_no = "3306";
        
        //Do not make changes to this string
        public static final String mysql_db_con = "jdbc:mysql://localhost:" + mysql_port_no + "/" + mysql_db_name;
        
    
}
