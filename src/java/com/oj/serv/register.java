/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.serv;

import com.oj.domain.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author brizz
 */
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
        
        PrintWriter out=response.getWriter();
        
        String uname=request.getParameter("uname");
        String name=request.getParameter("name");
        String pwd=request.getParameter("pwd");
        String email=request.getParameter("email");
        String gender=request.getParameter("gen");
        String pos=request.getParameter("pos");
        out.print(uname+" "+name+" "+pwd+" "+email);
        
        SessionFactory sf=(SessionFactory) request.getServletContext().getAttribute("sf");                                    // create one session means Connection
        Session s = sf.openSession();
                                            // before starting save(),update(), delete() operation we need to start TX
        User user =  (User) s.get(User.class,uname);
        if(user != null)
        {
            request.getSession().setAttribute("name", name);
            request.getSession().setAttribute("email", email);
            
            response.sendRedirect(request.getContextPath()+"/register.jsp?msg=already+exist");
        }
        Transaction tx = s.beginTransaction();
 
        try
        {
            User u=new User();
            u.setUsername(uname);
            u.setFullname(name);
            u.setEmail(email);
            u.setPassword(pwd);
            u.setInstitution("-");
            u.setCountry("-");
            u.setState("-");
            u.setCity("-");
            u.setPosition(pos);
            u.setRatings(0);
            u.setGlobelRank(0);
            u.setCountryRank(0);
            
            s.save(u);                              // stmt.addBatch("INSERT INTO school VALUES (....)");
    
 
            s.flush(); // stmt.executeBatch()
            tx.commit(); // con.commit();
            s.close();
            System.out.println("Records inserted");
        
            out.print("Registered :) ");
            response.sendRedirect(request.getContextPath()+"/home.jsp?msg=done");
            //HttpSession ses=request.getSession();
            //out.println(ses.getAttribute("lols"));
        }
        catch(Exception e)
        {
            tx.rollback();  
             s.close();
            out.print(e);// con.rollback();
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
