
package com.oj.serv;

import com.oj.domain.User;
import com.oj.domain.UserLikesComments;
import com.oj.domain.UserLikesCommentsId;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

@WebServlet(name = "savevote", urlPatterns = {"/savevote"})
public class savevote extends HttpServlet {

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String role=(String)request.getSession().getAttribute("role");
        String cid=(String)request.getParameter("id");
        String uname=(String)request.getSession().getAttribute("curruser");
        User user=null;
        
        SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
        Session s=sf.openSession();
        Transaction tx=null;
        if(role.equals("user"))
            user=(User)request.getSession().getAttribute("USER");
        else{
           user=(User)s.get(User.class,"admin");
           uname="admin";
        }
        UserLikesCommentsId pk=new UserLikesCommentsId(uname,Long.parseLong(cid));
        UserLikesComments ulc=new UserLikesComments();
        ulc.setId(pk);
        ulc.setUser(user);
        ulc.setUpdown(1);
        
        try{
            tx=s.beginTransaction();
            s.saveOrUpdate(ulc);
            tx.commit();
            s.flush();
            s.close();
            response.getWriter().write("done");
        }
        catch(Exception e){
            tx.rollback();
            s.flush();
            s.close();
            response.getWriter().write("error");
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String role=(String)request.getSession().getAttribute("role");
        String cid=(String)request.getParameter("id");
        String uname=(String)request.getSession().getAttribute("curruser");
        User user=null;
        
        SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
        Session s=sf.openSession();
        Transaction tx=null;
        if(role.equals("user"))
            user=(User)request.getSession().getAttribute("USER");
         else{
           user=(User)s.get(User.class,"admin");
           uname="admin";
        }
        UserLikesCommentsId pk=new UserLikesCommentsId(uname,Long.parseLong(cid));
        UserLikesComments ulc=new UserLikesComments();
        ulc.setId(pk);
        ulc.setUser(user);
        ulc.setUpdown(-1);
        
        try{
            tx=s.beginTransaction();
            s.saveOrUpdate(ulc);
            tx.commit();
            s.flush();
            s.close();
            response.getWriter().write("done");
        }
        catch(Exception e){
            tx.rollback();
            s.flush();
            s.close();
            response.getWriter().write("error");
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
