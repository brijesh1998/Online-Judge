<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.FileReader"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="com.oj.domain.Problems"%>

<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : addproblem.jsp
    Created on : 18 Mar, 2018, 5:41:23 PM
    Author     : brizz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Problem</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.min.css">
        <style>
        .footer {
           position: fixed;
           left: 0;
           bottom: 0;
           width: 100%;
           background-color: white;
           text-align: right;
           height: 50px;
          padding-right: 150px;
        }
        </style>
    </head>
    <body>
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
         <script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
         <script src="https://cdn.ckeditor.com/4.9.0/standard/ckeditor.js"></script>
         <%
             String uname=(String)request.getSession().getAttribute("role");
             String pcode=(String)request.getParameter("id");
             if(uname==null || uname.equals("admin") == false)
             response.sendRedirect(request.getContextPath()+"/home.jsp?msg=access+denied");
             else if(pcode == null)
             response.sendRedirect(request.getContextPath()+"/home.jsp?msg=id+not+selected");
             
              String role=(String)session.getAttribute("role");
            
                String pstmt=null,pinput=null,poutput=null,pconstrains=null,des=null,tcin=null,tcout=null,explain=null,ptime=null,pmem=null,psetter=null,pname=null;
                String code=null;
                boolean vis=false;
             try{
                  code=(String)request.getParameter("id").toUpperCase();
                String webpath=(String)request.getServletContext().getAttribute("webpath");
                 SessionFactory sf=(SessionFactory) request.getServletContext().getAttribute("sf");                                    // create one session means Connection
                 Session s = sf.openSession();
                 Problems po =  (Problems) s.get(Problems.class,code);
                 ptime=po.getTimelimit()+"";
                 pmem=po.getMemorylimit()+"";
                 psetter=po.getUser().getUsername();
                vis=po.isVisibletoall();
                JSONParser parser = new JSONParser();
                JSONObject jo = (JSONObject)parser.parse(new FileReader(webpath+"/problems/pstmts.json"));
                
                JSONObject json = (JSONObject) parser.parse((String)jo.get(code));
                
                pname=(String)json.get("pname");
                pcode=(String)json.get("pcode");
                pstmt=(String)json.get("pstmt");
                pinput=(String)json.get("pinput");
                poutput=(String)json.get("poutput");
                pconstrains=(String)json.get("pconstrains");
                des=(String)json.get("des");
                tcin=(String)json.get("tcin");
                tcout=(String)json.get("tcout");
                explain=(String)json.get("explain");
                 }
             catch(Exception e)
             {
                 response.sendRedirect(request.getContextPath()+"/home.jsp");
             }
         %>
         <div class="row">
            <div class="col">
                
                    <jsp:include page="../navbars/adminnav.jsp" />
                
            </div>
         </div>
        
                <div class="container">
                    <br/><br/>
                    <div class="row">
                        <div class="col">
                                 <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                <a class="nav-link active" data-toggle="tab" href="#stmt">Information</a>
                                </li>
                                
                               
                                 </ul>
                                <form method="post" action="${pageContext.request.contextPath}/editproblem?id=<%=pcode%>">
                                 <div class="tab-content">
                                     
                                    <div id="stmt" class="container tab-pane active"><br>
                                         <div class="row">
                                            <div class="col-2">
                                                <p><b>Problem Code</b></p>
                                            </div>
                                            <div class="col-4">
                                                 <div class="form-group">
            
                                                     <input type="text" class="form-control" id="pname" name="pcode" value="<%=pcode%>" placeholder="Unique Id" disabled/>
                                                </div>
                                            </div>
                                             
                                        </div>
                                        <div class="row">
                                            <div class="col-2">
                                                <p><b>Problem Name</b></p>
                                            </div>
                                            <div class="col-8">
                                                 <div class="form-group">
            
                                                     <input type="text" class="form-control" id="pname" name="pname" value="<%=pname%>" required/>
                                                </div>
                                            </div>
                                        </div>
                                        
                                       <div class="row">
                                           <div class="col-2">
                                                <p><b>Visible In Practice</b></p>
                                            </div>
                                        <div class="col-2">
                                            <div class="radio">
                                                        <label><input type="radio" value="1" name="visible"> Yes</label>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="radio">
                                                <label><input type="radio" value="0" name="visible"> No</label>
                                            </div>
                                        </div>
                                         <div class="col-6"></div>
                                         
                                    </div>
                                         <br/>
                                       
                                        <div class="row">
                                            <div class="col-2">
                                                <p><b>Problem Statement</b></p>
                                            </div>
                                            <div class="col-10">
                                                 <div class="form-group">
                                                     <textarea class="form-control" rows="2" id="pstmt" name="pstmt" required><%=pstmt%></textarea>
                                                </div>
                                               <script>
                                                    CKEDITOR.replace( 'pstmt' );
                                                </script>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-2">
                                                <p><b>Input Format</b></p>
                                            </div>
                                            <div class="col-10">
                                                 <div class="form-group">
                                                     <textarea class="form-control" rows="2" id="pinput" name="pinput" required><%=pinput%></textarea>
                                                </div>
                                               <script>
                                                    CKEDITOR.replace( 'pinput' );
                                                </script>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-2">
                                                <p><b>Constraints</b></p>
                                            </div>
                                            <div class="col-10">
                                                 <div class="form-group">
                                                     <textarea class="form-control" rows="2" id="cons" name="pconstraints" required><%=pconstrains%></textarea>
                                                </div>
                                               <script>
                                                    CKEDITOR.replace( 'cons' );
                                                </script>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-2">
                                                <p><b>Output Format</b></p>
                                            </div>
                                            <div class="col-10">
                                                 <div class="form-group">
                                                     <textarea class="form-control" rows="2" id="poutput" name="poutput" required><%=poutput%></textarea>
                                                </div>
                                               <script>
                                                    CKEDITOR.replace( 'poutput' );
                                                </script>
                                                <br/><br/>
                                            </div>
                                        </div>
                                    
                                            <div class="row">
                                                <div class="col-2">
                                                    <p><b>Time LImit</b></p>
                                                </div>
                                                <div class="col-3">
                                                     <div class="form-group">
                                                         <input type="text" class="form-control" id="ptime" placeholder="In Seconds" name="ptime" value="<%=ptime%>" required/>
                                                    </div>
                                                    <br/><br/>
                                                </div>
                                                <div class="col-2">
                                                    <p><b>Memory Limit</b></p>
                                                </div>
                                                <div class="col-3">
                                                     <div class="form-group">
                                                         <input type="text" class="form-control" id="pmem" placeholder="In MB" name="pmem" value="<%=pmem%>" required/>
                                                    </div>
                                                    <br/><br/>
                                                </div>
                                            </div>
                                        <div class="row">
                                            <div class="col-2">
                                                <p><b>Sample Test Case Input</b></p>
                                            </div>
                                            <div class="col-3">
                                                 <div class="form-group">
                                                     <textarea class="form-control" rows="4" id="samin" name="samin" placeholder="Input" required><%=tcin%></textarea>
                                                </div>
                                               <script>
                                                    CKEDITOR.replace( 'samin' );
                                                </script>
                                            </div>
                                            <div class="col-2">
                                                <p><b>Sample Test Case Output</b></p>
                                            </div>
                                            <div class="col-3">
                                                 <div class="form-group">
                                                     <textarea class="form-control" rows="4" id="samout" name="samout" placeholder="Output" required><%=tcout%></textarea>
                                                </div>
                                              <script>
                                                    CKEDITOR.replace( 'samout' );
                                                </script>
                                            </div>
                                        </div>
                                         <div class="row">
                                             <div class="col-2">
                                                <p><b>Explanation Of Sample Test Case</b></p>
                                            </div>
                                            <div class="col-10">
                                                 <div class="form-group">
                                                     <textarea class="form-control" rows="2" id="explain" name="explain" ><%=explain%></textarea>
                                                </div>
                                               <script>
                                                    CKEDITOR.replace( 'explain' );
                                                </script>
                                                <br/><br/>
                                            </div>
                                        </div>
                                            
                                              <div class="footer">
                                          <div class="row">
                                            <div class="col">
                                                <button  type="submit" value="testdata" name="save" id="save" class="btn btn-primary">Save Changes</button>
                                            </div>
                                            </div>
                                                  
                                        </div>
                                      
                                      </div>
                                         
                                        
                                     
                                 </div>
                                    </form>
                        </div>
                    </div>
                </div>
    </body>
</html>
