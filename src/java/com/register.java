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

/**
 *
 * @author ruchir-pc
 */
@WebServlet(name = "register", urlPatterns = {"/register"})
public class register extends HttpServlet {

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
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<link rel=\'stylesheet\' href=\'styLe/login_reset.css\'>");
            out.println("<link rel=\'stylesheet\' href=\'style/login_style.css\'>");
            out.println("");
            
            out.println("<title>REGISTRATION</title>");              
            out.println("</head>");
            out.println("<body>");
            //out.println("<h1>Servlet register at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                String db_con = LuceneConstants.db_connection;
                Connection con = DriverManager.getConnection(db_con);
                
                //Extract max user_id
                int user_id=5000;
                PreparedStatement ps=con.prepareStatement("select max(user_id) from user_details");
                ResultSet rs=ps.executeQuery();
                if(rs.next())
                {
                    System.out.println("Inside");
                    user_id = rs.getInt("max(user_id)")+1;
                }
                
                //Insert data into table
                String command="Insert into user_details values(?,?,?,?,?)";
                PreparedStatement pstmt = con.prepareStatement(command);
                pstmt.setString(1, uname);
                pstmt.setString(2, pass);
                pstmt.setInt(3, user_id);
                pstmt.setString(4, email);
                pstmt.setString(5, name);
                
            
                int i =pstmt.executeUpdate();
                if(i==1)
                {
                   
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Registered Succesfully');");
                    out.println("location='index.html';");
                    out.println("</script>");
                }
                else
                {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Registraion Aborted');");
                    out.println("location='register.html';");
                    out.println("</script>");
                }
            }catch(Exception e)
            {
                System.out.println("Exception in Registration: "+ e);
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
