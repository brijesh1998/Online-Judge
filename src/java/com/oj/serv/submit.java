
package com.oj.serv;

import com.oj.compile.CExecutor;
import com.oj.compile.CppExecutor;
import com.oj.compile.JavaExecutor;
import com.oj.compile.ProcessExecutor;
import com.oj.domain.Problems;
import com.oj.domain.Submissions;
import com.oj.domain.User;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.concurrent.ExecutorService;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

@MultipartConfig(fileSizeThreshold=1024*1024*10, maxFileSize=1024*1024*50,maxRequestSize=1024*1024*200)

public class submit extends HttpServlet {
     volatile String runstatus;
     boolean isDone;
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length()-1);
            }
        }
        return "";
    }
    private String upload(HttpServletRequest request, HttpServletResponse response,String sid,String ext) throws IOException, ServletException
    {
         String appPath = (String)request.getServletContext().getAttribute("webpath");
       
         String savePath = appPath + File.separator + "Usercode";
    //  response.getWriter().print(request.getParts().size());
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
        String fileName=null;
        
        for (Part part : request.getParts()) {
            fileName = extractFileName(part);
            // refines the fileName in case it is an absolute path
           // response.getWriter().print(fileName);
            fileName = new File(fileName).getName();
            
            if(fileName != "")
            {
                part.write(savePath + File.separator + sid + "."+ext);
                return sid + "."+ext;
            }
        }
        return "";
    }
    synchronized private Long getSid(String pcode,User u)
    {
        Configuration c = new Configuration();
        
        c.configure("/com/oj/cfgs/hibernate.cfg.xml");
                                           
        SessionFactory sf=c.buildSessionFactory();
        Session s=sf.openSession();
        Submissions sub=new Submissions((Problems)s.get(Problems.class,pcode),u,null,null,0,0,null);
        Transaction tx=null;
        try{
        tx=s.beginTransaction();
        s.save(sub);
        tx.commit();
        s.close();
        sf.close();}
        catch(HibernateException e){tx.rollback();
        s.close();
        sf.close();}
        return sub.getSubmissionid();
    }
  
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String webpath=(String)request.getServletContext().getAttribute("webpath");
        String srcpath=(String)request.getServletContext().getAttribute("srcpath");
        String pcode=(String)request.getSession().getAttribute("probtosolve");
        PrintWriter out=response.getWriter();
        //out.println(request.getParts().size());
        Long sid=getSid(pcode,(User)request.getSession().getAttribute("USER"));
        //out.println(sid);
        //out.println(request.getParts().size());
        String ulan=(String)request.getParameter("lan");
        String codeid=upload(request,response,sid+"",ulan);
        System.out.println("uploaded as....."+codeid);
        runstatus="In Queue...";
        ProcessExecutor cpp=new CppExecutor("/Usercode/"+codeid,webpath+"/testdata/",webpath,srcpath,null,"cpp");
                ProcessExecutor java=new JavaExecutor("/Usercode/"+codeid,webpath+"/testdata/",webpath,srcpath,null,"java");
                 ProcessExecutor clan=new CExecutor("/Usercode/"+codeid,webpath+"/testdata/",webpath,srcpath,null,"c");
               // ProcessExecutor py=new PythonExecutor("/Usercode/"+codeid,null,webpath,srcpath,null,"py");
                cpp.setNextExecutor(java);
                java.setNextExecutor(clan);
                
         Runnable r=new Runnable(){
                 
                //System.out.println("ended...2");
             
            @Override
            public void run() {
                System.out.println("started...");
                
                runstatus="Compiling & Running...";
                isDone=cpp.doTask(ulan,sid,pcode);
               
                runstatus="done";
                System.out.println(isDone+ " ended...");
                 //To change body of generated methods, choose Tools | Templates.
            }
         };
         ExecutorService ex=(ExecutorService)request.getServletContext().getAttribute("executor");
         ex.submit(r);
        System.out.println("\n\nresponse sent...");
        
        response.setStatus(HttpServletResponse.SC_ACCEPTED);
        response.sendRedirect(request.getContextPath()+"/problems/running.jsp?id="+sid);
        
        
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
       
        
       response.getWriter().write(runstatus);
        
       System.out.println(runstatus);
       response.setStatus(HttpServletResponse.SC_OK);
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
