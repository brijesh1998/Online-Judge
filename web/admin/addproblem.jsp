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
             if(uname==null || uname.equals("admin") == false)
             response.sendRedirect(request.getContextPath()+"/home.jsp?access+denied");
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
                                <form method="post" action="${pageContext.request.contextPath}/addproblem" enctype='multipart/form-data'>
                                 <div class="tab-content">
                                     
                                    <div id="stmt" class="container tab-pane active"><br>
                                         <div class="row">
                                            <div class="col-2">
                                                <p><b>Problem Code</b></p>
                                            </div>
                                            <div class="col-4">
                                                 <div class="form-group">
            
                                                     <input type="text" class="form-control" id="pname" name="pcode" placeholder="Unique Id" required/>
                                                </div>
                                            </div>
                                             
                                        </div>
                                        <div class="row">
                                            <div class="col-2">
                                                <p><b>Problem Name</b></p>
                                            </div>
                                            <div class="col-8">
                                                 <div class="form-group">
            
                                                <input type="text" class="form-control" id="pname" name="pname" required/>
                                                </div>
                                            </div>
                                        </div>
                                         <div class="row">
                                            <div class="col-2">
                                                <p><b>Difficulty</b></p>
                                            </div>
                                            <div class="col-4">
                                                 <div class="form-group">
            
                                                      <select class="form-control" name="pdiff" id="sel1">
                                                            <option value="easy">Easy</option>
                                                            <option value="medium">Medium</option>
                                                            <option value="hard">Hard</option>
                                                            <option value="expert">Expert</option>
                                              </select>
                                                </div>
                                            </div>
                                             
                                        </div>
                                        <div class="row">
                                            <div class="col-2"></div>
                                            <div class="col">
                                                
                                             <div class="form-check">
                                                 <input type="checkbox" class="form-check-input" id="visible" name="visible" value="visible"/>
                                            <label class="form-check-label" for="visible">Add this problem to practice direct</label>
                                           
                                             </div>
                                                 <br/>
                                            </div>
                                             
                                        </div>
                                         
                                        <div class="row">
                                            <div class="col-2">
                                                <p><b>Description</b></p>
                                            </div>
                                            <div class="col-9">
                                                 <div class="form-group">
                                                     <textarea class="form-control" maxlength="150" placeholder="Short summry" rows="2" id="des" name="des" required></textarea>
                                                </div>
                                               
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-2">
                                                <p><b>Problem Statement</b></p>
                                            </div>
                                            <div class="col-10">
                                                 <div class="form-group">
                                                     <textarea class="form-control" rows="2" id="pstmt" name="pstmt" ></textarea>
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
                                                     <textarea class="form-control" rows="2" id="pinput" name="pinput" required></textarea>
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
                                                     <textarea class="form-control" rows="2" id="cons" name="pconstraints" required></textarea>
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
                                                     <textarea class="form-control" rows="2" id="poutput" name="poutput" required></textarea>
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
                                                         <input type="text" class="form-control" id="ptime" placeholder="In Seconds" name="ptime" required/>
                                                    </div>
                                                    <br/><br/>
                                                </div>
                                                <div class="col-2">
                                                    <p><b>Memory Limit</b></p>
                                                </div>
                                                <div class="col-3">
                                                     <div class="form-group">
                                                         <input type="text" class="form-control" id="pmem" placeholder="In MB" name="pmem" required/>
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
                                                     <textarea class="form-control" rows="4" id="samin" name="samin" placeholder="Input" required></textarea>
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
                                                     <textarea class="form-control" rows="4" id="samout" name="samout" placeholder="Output" required></textarea>
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
                                                     <textarea class="form-control" rows="2" id="explain" name="explain" ></textarea>
                                                </div>
                                               <script>
                                                    CKEDITOR.replace( 'explain' );
                                                </script>
                                                <br/><br/>
                                            </div>
                                        </div>
                                             <div class="row">
                                                 <div class="col-2">
                                                    <p><b>Test Data</b></p>
                                                 </div>
                                                <div class="col-3">
                                                    
                                                     <div class="custom-file">
                                                        <input type="file" class="custom-file-input" id="tcfile" name="tcfile" required>
                                                        <label class="custom-file-label" for="tcfile">Choose zip file...</label>
                                                        <div><p>zip file should contain only intput and output files in separate folder, e.g. input00.txt,output00.txt</p></div>
                                                      </div>
                                                    <br/><br/><br/><br/><br/><br/>
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
