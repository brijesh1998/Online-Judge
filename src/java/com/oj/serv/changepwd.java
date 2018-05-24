/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.serv;

import com.oj.beans.SendMailBean;
import com.oj.domain.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import javax.mail.*;  
import javax.mail.internet.*;  
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author brizz
 */
@WebServlet(name = "changepwd", urlPatterns = {"/changepwd"})
public class changepwd extends HttpServlet {

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
        
        String uid=(String)request.getParameter("user");
       
        if(uid == null)
        {}
        else
        {
            String appurl=request.getRequestURL().toString();
            String ran=SendMailBean.sendMailForChangePWD(uid,appurl.substring(0,appurl.indexOf(request.getContextPath()))+request.getContextPath()+"/forgot.jsp");
            request.getServletContext().setAttribute(uid,ran);
           // response.getWriter().write(ran);
           
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String uid=(String)request.getParameter("userid");
        String pwd=(String)request.getParameter("pwd1");
        
       // response.getWriter().println(uid+" "+pwd);
        SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
            org.hibernate.Session s = sf.openSession();
           
           PrintWriter out=response.getWriter();
       
            User u =  (User) s.get(User.class,uid);
            
           Transaction tx = null;
 
        try
        {
            u.setPassword(pwd);
           tx=s.beginTransaction();
           s.update(u); 
           tx.commit(); // con.commit();
          s.flush();
          s.close();
          
          //  out.print("Registered :) ");
          request.getServletContext().setAttribute(uid,null);
           response.sendRedirect(request.getContextPath()+"/home.jsp");
        }
        catch(Exception e)
        {
            tx.rollback();  
            s.flush();
            s.close();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
          //  out.print(e);// con.rollback();
        }
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
