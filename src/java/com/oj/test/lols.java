/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.test;

import com.oj.domain.Problems;
import com.oj.domain.Submissions;
import com.oj.domain.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author brizz
 */
@WebServlet(name = "lols", urlPatterns = {"/lols"})
public class lols extends HttpServlet {

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
    
            SessionFactory sf=(SessionFactory) request.getServletContext().getAttribute("sf");                                    // create one session means Connection
        Session s = sf.openSession();
                                            // before starting save(),update(), delete() operation we need to start TX
        
        Transaction tx = s.beginTransaction();
        PrintWriter out=response.getWriter();
        
        try
        {
            Submissions sub=new Submissions();
            sub.setCodepath("dsdsds");
            sub.setProblems((Problems)s.get(Problems.class,"BPERIK"));
            sub.setUser((User)s.get(User.class,"admin"));
            sub.setTimetaken(0);
            sub.setVerdict("AC");
            sub.setMemoryused(0);
           
            s.save(sub);                             
    
 
            s.flush(); // stmt.executeBatch()
            tx.commit(); // con.commit();
            s.close();
            System.out.println("Records inserted");
        
            out.print(sub.getSubmissionid() + " Registered :) ");
           // response.sendRedirect("auth/home.jsp?msg=done");
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
