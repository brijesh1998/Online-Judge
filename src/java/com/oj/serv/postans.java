
package com.oj.serv;

import com.oj.domain.Comments;
import com.oj.domain.Discuss;
import com.oj.domain.User;
import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

@WebServlet(name = "postans", urlPatterns = {"/postans"})
public class postans extends HttpServlet {

 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String role=(String)request.getSession().getAttribute("role");
        String qid=(String)request.getParameter("id");
        String cbody=(String)request.getParameter("cbody");
        User user=null;
       
        SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
        Session s=sf.openSession();
         if(role.equals("user"))
            user=(User)request.getSession().getAttribute("USER");
        else
           user=(User)s.get(User.class,"admin");
         
          //response.getWriter().println(user.getUsername());

        Transaction tx=null;
        Comments c=new Comments();
        c.setBody(cbody);
        c.setDatetime(new Date());
        c.setUser(user);
        c.setApproved(false);
        c.setDiscuss((Discuss)s.get(Discuss.class,Long.parseLong(qid)));
        try
        {
            tx=s.beginTransaction();
            s.save(c);
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
        
       // response.getWriter().println("done");
       response.sendRedirect(request.getContextPath()+"/questions.jsp?id="+qid);
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
       
         String cid=(String)request.getParameter("id");
         SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
         Session s=sf.openSession();
        
         
        Transaction tx=null;
        Comments c=(Comments)s.get(Comments.class,Long.parseLong(cid));
        c.setApproved(!c.isApproved());
       
        try
        {
            tx=s.beginTransaction();
            s.update(c);
            tx.commit();
            s.flush();
            s.close();
            response.getWriter().write("done");
        }
        catch(Exception e)
        {
            tx.rollback();
            s.flush();
            s.close();
            response.getWriter().write("error");
            System.out.println("ERRORRORRO: "+ e);
        }
        
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
