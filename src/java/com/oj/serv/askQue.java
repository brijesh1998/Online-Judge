
package com.oj.serv;

import com.oj.domain.Discuss;
import com.oj.domain.User;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;


@WebServlet(name = "askQue", urlPatterns = {"/askQue"})
public class askQue extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
        SimpleDateFormat ft = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
        Date date = new Date();  

        String role=(String)request.getSession().getAttribute("role");
        String title=(String)request.getParameter("title");
        String dt=ft.format(date);
        String qbody=(String)request.getParameter("qbody");
        String uname=(String)request.getSession().getAttribute("curruser");
        if(role.equals("admin"))
            uname="admin";
        //response.getWriter().println("Title: "+title+"\nUser: "+uname+"\nbody: "+qbody+"\nDate:  "+date+"role: "+role);
        SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
        Session s=sf.openSession();
        Transaction tx=null;
       try{
        Discuss d=new Discuss();
        d.setTitle(title);
        d.setDatetime(dt);
        d.setBody(qbody);
        d.setUser((User)s.get(User.class,uname));
        
        
       
            tx=s.beginTransaction();
            s.save(d);
            tx.commit();
            s.flush();
            s.close();
            
        }
        catch(Exception e)
        {
            tx.rollback();
            s.flush();
            s.close();
            System.out.println("ERRORRORRO: "+ e);
        }
        response.sendRedirect(request.getContextPath()+"/discuss.jsp?msg=done");
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
