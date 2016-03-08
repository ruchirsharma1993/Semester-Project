
package com;

import com.LuceneConstants;
import java.io.File;
import java.io.IOException;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ruchir-pc
 */
public class Searcher {
    IndexSearcher indexSearcher;
	QueryParser queryParser;
	Query query;
	Boolean ad_search;
        
	public Searcher(String indexDirectoryPath, Boolean searchType) throws IOException {
		Directory indexDirectory = FSDirectory.open(new File(indexDirectoryPath));
		indexSearcher = new IndexSearcher(indexDirectory);
		queryParser = new QueryParser(Version.LUCENE_36,
				LuceneConstants.CONTENTS, new StandardAnalyzer(Version.LUCENE_36));
                ad_search = searchType;
	}
	
	public TopDocs search(String searchQuery) throws IOException, org.apache.lucene.queryParser.ParseException {
		
		query = queryParser.parse(searchQuery);
                if(ad_search)
                    return indexSearcher.search(query, LuceneConstants.MAX_SEARCH_ADS);
                else
                    return indexSearcher.search(query, LuceneConstants.MAX_SEARCH_NEWS);
	}
	
	public Document getDocument(ScoreDoc scoreDoc) throws CorruptIndexException, IOException {
		
		return indexSearcher.doc(scoreDoc.doc);		
	}
	
	public void close() throws IOException {
		indexSearcher.close();
	}
    
}
