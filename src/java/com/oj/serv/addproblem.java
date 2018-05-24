package com.oj.serv;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.google.gson.Gson;
import com.oj.compile.Unzipper;
import com.oj.domain.Admin;
import com.oj.domain.ProblemStmt;
import com.oj.domain.Problems;
import com.oj.domain.User;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author brizz
 */
@WebServlet(urlPatterns = {"/addproblem"})
@MultipartConfig(fileSizeThreshold=1024*1024*10, // 2MB
                 maxFileSize=1024*1024*50,      // 10MB
                 maxRequestSize=1024*1024*200)   // 50MB
public class addproblem extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
       PrintWriter out=response.getWriter();
       
        String pcode=(String)request.getParameter("pcode").toUpperCase();
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
        String se=null;
        boolean done=false,validfile=true;
        SessionFactory sf=(SessionFactory) request.getServletContext().getAttribute("sf");                                    // create one session means Connection
        Session s = sf.openSession();
        Transaction tx=null;
        Problems po =  (Problems) s.get(Problems.class,pcode);
        if(po != null)
        {
           
            response.sendRedirect("admin/addproblem.jsp?msg=error");
        }
        try{
        String appPath = (String)request.getServletContext().getAttribute("webpath");
        // constructs path of the directory to save uploaded file
        String savePath = appPath + File.separator + "testdata" +File.separator + pcode;
         
        // creates the save directory if it does not exists
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
        String fileName=null;
        File file=null;
        for (Part part : request.getParts()) {
            fileName = extractFileName(part);
            // refines the fileName in case it is an absolute path
          //  out.print(fileName);
            fileName = new File(fileName).getName();
            
            
            if(fileName != ""){
                if(fileName.substring(fileName.length() - 4).equals(".zip") == false){
                    validfile=false;
                    break;}
                part.write(savePath + File.separator + fileName);
             Unzipper.unzip(savePath + File.separator + fileName,savePath);
             file = new File(savePath + File.separator + fileName);
             file.delete();
            }
        }
        
        
            tx = s.beginTransaction();
        
            if(validfile){
            Problems p=new Problems();
            p.setProblemcode(pcode.toUpperCase());
            p.setDifficulty(pdiff);
            if(vis != null)
            p.setBelongsto("practice");
            else
                p.setBelongsto("contest");
            p.setTimelimit(Float.parseFloat(ptime));
            p.setUser((User)s.get(User.class,"admin"));
            p.setAdmin((Admin)s.get(Admin.class,"admin"));
            p.setMemorylimit(Float.parseFloat(pmem));
            p.setVisibletoall(false);
            p.setProblempath("/problems/pstmts.json");
            s.save(p);                             
    
 
            s.flush(); // stmt.executeBatch()
            tx.commit(); // con.commit();
            s.close();
           // System.out.println("Records inserted");
        
            out.print("Records inserted :) ");
            done=true;
            }
            else{
               
                out.print("not zip ");
            }
            
        }
        catch(Exception e)
        {
            tx.rollback();  
             s.close();
            out.print(e);// con.rollback();
        }
        if(done)
        {   try{
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(addproblem.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(addproblem.class.getName()).log(Level.SEVERE, null, ex);
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
