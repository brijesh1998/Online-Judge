
package com.oj.serv;

import com.google.gson.Gson;
import com.oj.domain.ProblemStmt;
import com.oj.domain.Problems;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


@WebServlet(name = "editproblem", urlPatterns = {"/editproblem"})
public class editproblem extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pcode=(String)request.getParameter("id").toUpperCase();
        String pname=(String)request.getParameter("pname");
        String pstmt=(String)request.getParameter("pstmt");
        String pinput=(String)request.getParameter("pinput");
        String poutput=(String)request.getParameter("poutput");
        String pdiff=(String)request.getParameter("pdiff");
        String des=(String)request.getParameter("des");
        String vis=(String)request.getParameter("visible");
        String pconstraints=(String)request.getParameter("pconstraints");
        String samin=(String)request.getParameter("samin");
        String samout=(String)request.getParameter("samout");
        String explain=(String)request.getParameter("explain");
        String ptime=(String)request.getParameter("ptime");
        String pmem=(String)request.getParameter("pmem");
       boolean done=false;
        Configuration c = new Configuration();
        
        c.configure("/com/oj/cfgs/hibernate.cfg.xml");
                                           
        SessionFactory sf=c.buildSessionFactory();
        Session s=sf.openSession();
        Transaction tx=null;
        try{
            Problems p=(Problems)s.get(Problems.class,pcode);
            p.setTimelimit(Float.parseFloat(ptime));
            p.setMemorylimit(Float.parseFloat(pmem));
            p.setVisibletoall(vis.equals("1"));

            tx=s.beginTransaction();
            s.update(p);
            tx.commit();
            s.flush();
            s.close();
            sf.close();
            done=true;
        }
        catch(Exception ex)
        {
            tx.rollback();
            s.flush();
            s.close();
            sf.close();
        }
        if(done){
            try{
                String webpath=(String)request.getServletContext().getAttribute("webpath");
                JSONParser parser = new JSONParser();
                Gson gson=new Gson();
                JSONObject pjo=(JSONObject) parser.parse(new FileReader(webpath+"/problems/pstmts.json"));
                ProblemStmt stmt=new ProblemStmt(pcode,pname,pstmt,pinput,poutput,pconstraints,des,samin,samout,explain);
                pjo.put(pcode, gson.toJson(stmt));
                try (FileWriter file = new FileWriter(webpath+"/problems/pstmts.json")) {
			file.write(pjo.toString());
                        
		}
            }
            catch(Exception e)
            {}
            response.sendRedirect(request.getContextPath()+"/home.jsp");
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
