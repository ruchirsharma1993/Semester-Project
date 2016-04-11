/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.*;
import org.json.JSONArray;
import org.json.JSONObject;

      
import com.memetix.mst.language.Language;
import com.memetix.mst.translate.Translate;

/**
 *
 * @author ruchir-pc
 * NOTE: THIS IS A SAMPLE CODE FOR TESTING BING API
 */


/*
**********
Sample REQUEST:
****************
GET https://bingapis.azure-api.net/api/v5/news?category=sports&mkt=en-us HTTP/1.1
Ocp-Apim-Subscription-Key: 123456789ABCDE
User-Agent: Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch; NOKIA; Lumia 822)
X-Search-ClientIP: 999.999.999.999
X-MSEdge-ClientID: <blobFromPriorResponseGoesHere>
Host: bingapis.azure-api.net
*/
public class get_catnews 
{
    public static void main(String args[]) throws Exception
    {
  
        try{
            Translate.setClientId("000000004818E476");
            Translate.setClientSecret("nNvJWCKNw7cK37TqOABzIdcSkgJZzWQV");

            String translatedText = Translate.execute("Bonjour le monde", Language.FRENCH, Language.ENGLISH);

            System.out.println(translatedText);
        }
        catch(Exception e) {
            System.err.println("Exception: " + e.getMessage());
        }
    
       /* //String bing_url = "https://bingapis.azure-api.net/api/v5/news?category=sports&mkt=en-us";
        String search_category = "Sports";
        String bing_url = "https://bingapis.azure-api.net/api/v5/news?category=" + search_category +"&mkt=en-us";
                                    
        URL obj = new URL(bing_url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod("GET");
        //con.setRequestProperty("User-Agent", "Mozilla/5.0");
        con.setRequestProperty("Host", "bingapis.azure-api.net");
        con.setRequestProperty("Ocp-Apim-Subscription-Key","d4333a2bf2404242a07e3e2ee230586a");
        
        int responseCode = con.getResponseCode();
        System.out.println("GET Response Code :: " + responseCode);
        if (responseCode == HttpURLConnection.HTTP_OK) { // success
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();
 
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
 
            // print result
            System.out.println(response.toString());
             final JSONObject json = new JSONObject(response.toString());
           
            final JSONArray results = json.getJSONArray("value");
            final int resultsLength = results.length();
            for (int i = 0; i < resultsLength; i++) {
                final JSONObject aResult = results.getJSONObject(i);
                System.out.println(aResult.get("url"));
            } 
        } else {
            System.out.println("GET request not worked");
        }*/
    }
    
}
