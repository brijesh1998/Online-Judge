/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.serv;

import com.oj.domain.Admin;
import com.oj.domain.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author brizz
 */
public class validate extends HttpServlet {

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
       String uname=request.getParameter("uname");
      
        String pwd=request.getParameter("pwd");
        String from=request.getParameter("from");
        String id=request.getParameter("id");
        if(from == "" || from== null)
            from="home.jsp";
        if(from.equals("problem.jsp"))
            from="problems/"+from;
        if(id == null)
            from=null;
        else{
        if(!id.equals("yes"))
            from+="?id="+id;}
        Configuration c = new Configuration();
        
        c.configure("/com/oj/cfgs/hibernate.cfg.xml");
                                             // SessionFactory holds cfg file properties like
                                             // driver props and hibernate props and mapping file
        SessionFactory sf=c.buildSessionFactory();
                                            // create one session means Connection
        Session s = sf.openSession();
       // PrintWriter out=response.getWriter();
       // out.print(uname + " "+pwd);
                                            // before starting save(),update(), delete() operation we need to start TX
        User user =  (User) s.get(User.class,uname);
        Admin admin =(Admin)s.get(Admin.class, uname);
        String nextpage=request.getContextPath()+"/register.jsp?msg=Username+or+Password+invalid";
        if(user != null && user.getPassword().equals(pwd))
        {
            HttpSession ses=request.getSession();
            ses.setAttribute("curruser",uname);
            ses.setAttribute("USER", user);
            ses.setAttribute("role","user");
            if(from != null)
           nextpage=request.getContextPath()+"/"+from;
            else
                nextpage=request.getContextPath()+"/home.jsp";
        }
        else if(admin != null && admin.getPassword().equals(pwd)){
            HttpSession ses=request.getSession();
            ses.setAttribute("curruser",uname);
            ses.setAttribute("USER", user);
            ses.setAttribute("role", "admin");
           if(from != null)
           nextpage=request.getContextPath()+"/"+from;
            else
            nextpage=request.getContextPath()+"/home.jsp";
            
        }
        response.sendRedirect(nextpage);
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
