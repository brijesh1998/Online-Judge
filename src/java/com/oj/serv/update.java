/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.serv;

import com.oj.domain.User;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author brizz
 */
@MultipartConfig(fileSizeThreshold=1024*1024*10, maxFileSize=1024*1024*50,maxRequestSize=1024*1024*200)

public class update extends HttpServlet {

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
    private String upload(HttpServletRequest request, HttpServletResponse response,String sid,String ext) throws IOException 
    {
         String appPath = (String)request.getServletContext().getAttribute("webpath");
       
         String savePath = appPath + File.separator + "Userdata";
         try{
      response.getWriter().print("ertyjhgfdsdfghjjhgfd");
      response.getWriter().println(request.getParts().size());
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
        String fileName=null;
        
        for (Part part : request.getParts()) {
            fileName = extractFileName(part);
            // refines the fileName in case it is an absolute path
            response.getWriter().print("here: "+fileName);
            fileName = new File(fileName).getName();
            
            if(fileName != "")
            {
                response.getWriter().print(fileName);
                part.write(savePath + File.separator + sid + "."+ext);
                return sid + "."+ext;
            }
        }
         }
         catch(Exception e)
         {
             System.out.println("erororo+ "+e);
         }
        return "";
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uname=(String)request.getSession().getAttribute("curruser");
        String name=request.getParameter("name");
        String aboutme=request.getParameter("aboutme");
        String motto=request.getParameter("motto");
        String link=request.getParameter("link");
        String email=request.getParameter("email");
        String inst=request.getParameter("inst");
        String cnty=request.getParameter("cnty");
        String state=request.getParameter("state");
        String city=request.getParameter("city");
        
        String pos=request.getParameter("pos");
        SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
            Session s = sf.openSession();
           
           PrintWriter out=response.getWriter();
            out.println(name+" "+pos+" "+aboutme+" "+motto+" "+email);
     
            User u =  (User) s.get(User.class,uname);
            
           Transaction tx = null;
 
        try
        {
            u.setFullname(name);
            u.setEmail(email);
            u.setAboutme(aboutme);
            u.setMotto(motto);
            u.setPosition(pos);
            u.setLink(link);
            u.setInstitution(inst);
            u.setCountry(cnty);
            u.setState(state);
            u.setCity(city);
 
           tx=s.beginTransaction();
           s.update(u); 
           tx.commit(); // con.commit();
          s.flush();
          s.close();
            System.out.println("Records inserted");
        
          //  out.print("Registered :) ");
          try{
         upload(request,response,uname,"png");}
          catch(Exception e){
              System.out.println("QWWED EROR: "+e);
          }
           response.sendRedirect(request.getContextPath()+"/profile.jsp");
            //HttpSession ses=request.getSession();
            //out.println(ses.getAttribute("lols"));
        }
        catch(Exception e)
        {
            tx.rollback();  
            s.flush();
            s.close();
          //  out.print(e);// con.rollback();
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
