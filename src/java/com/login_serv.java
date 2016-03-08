/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ruchir-pc
 */
@WebServlet(name = "login_serv", urlPatterns = {"/login_serv"})
public class login_serv extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String uname = request.getParameter("user");
        String pass = request.getParameter("password");
        
        try (PrintWriter out = response.getWriter()) 
        {
            /* TODO output your page here. You may use following sample code. */
            
   
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<link rel=\'stylesheet\' href=\'styLe/login_reset.css\'>");
            out.println("<link rel=\'stylesheet\' href=\'style/login_style.css\'>");
            out.println("");
            
            out.println("<title>LOGGING IN</title>");            
            out.println("</head>");
            out.println("<body>");
            //out.println("<h1>Servlet login_serv at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            
            try
            {
                  Class.forName("com.mysql.jdbc.Driver");
                  String db_con = LuceneConstants.db_connection;
                  Connection con = DriverManager.getConnection(db_con);
                  PreparedStatement ps=con.prepareStatement("select * from user_details where uname=? and pass=?");
                  ps.setString(1, uname);
                  ps.setString(2, pass);
                  ResultSet rs=ps.executeQuery();
                  if(rs.next())
                  {
                      //Login Succesful, create session and redirect to home page
                      String user_id = rs.getString("user_id");
                      HttpSession session = request.getSession();
                      session.setAttribute("uname",uname);
                      session.setAttribute("user_id",user_id);
                      
                     /* //JS for succesful login
                     
                      out.println("<script type=\"text/javascript\">");
                      out.println("alert('Login Succesful !! Redirecting');");
                      out.println("location='home.jsp';");
                      out.println("</script>");     */
                     
                     response.sendRedirect("home.jsp");
                   
                  }
                  else
                  {
                      //Show Error Message
                      out.println("<script type=\"text/javascript\">");
                      out.println("alert('Invalid Credentails !! Try Again');");
                      out.println("location='index.html';");
                      out.println("</script>");   
                     
                      
                  }
            }catch(Exception e)
            {
                System.out.println("Exception in checking login credentials: "+e);
            }
          

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
