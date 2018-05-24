<%-- 
    Document   : submit
    Created on : 15 Mar, 2018, 11:18:31 PM
    Author     : brizz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.min.css">
        <title>JSP Page</title>
    </head>
    <body>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
         <script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
         <script>
             
             function checkFile()
             {  
                 document.getElementById("alert").style.visibility="hidden";
                 var x=document.getElementById("ucode");
                 var file=x.files[0];
                 
                 if(!file.type.startsWith("text/"))
                 {
                     document.getElementById("submit").disabled=true;
                     document.getElementById("alert").style.visibility="visible";
                 }
                 else{
                     document.getElementById("submit").disabled=false;
                 }
             }
             
         </script>
         <div class="row">
            <div class="col">
               
                    <%
                        String appurl=(String)request.getServletContext().getAttribute("appurl");
                        String curruser=(String)session.getAttribute("curruser");
                        if(curruser == null)
                        response.sendRedirect(request.getContextPath()+"/register.jsp?msg=auth");
                        
                        request.getSession().setAttribute("runstatus", "Submiting...");
                        %>
               
                <c:if test="${sessionScope.curruser != null}">
                    <jsp:include page="../navbars/logoutnav.jsp" />
                </c:if>
            </div>
         </div>
                <%
                    String probtosolve=(String)session.getAttribute("probtosolve");
                %>
              
              
                <div class="container">
                    <br/><br/>
                    <div id="alert" class="alert alert-danger alert-dismissible fade show" style="visibility: hidden" role="alert">
                        <strong>Error !</strong> Only text file is expected.
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                        </button>
                      </div>
                    <div class="row">
                      
                        <div class="col"><br/><br/>
                            <h3><b>Submission for Problem <a href="#"><%=probtosolve%></a></b></h3>
                            <hr style="height:1px;border:none;color:#333;background-color:#333;" />
                        </div>
                    </div>
                            <form class="was-validated" method="post" action="${pageContext.request.contextPath}/submit" enctype='multipart/form-data'>
                            <div class="row">
                                <div class="col-3">
                                    <select class="form-control" name="lan" id="lan">
                                        <option disabled>--select language--</option>
                                        <option  value="c">C (gcc)</option>
                                        <option  value="cpp">C++ (gcc6.3)</option>
                                        <option value="java">JAVA 8</option>
                                        <<!--<option value="py">Python 3</option> -->
                                      </select>
                                </div>    
                            </div>
                            <div class="row">
                                <div class="col-3">
                                    <br/><br/>
                                     <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="ucode" name="ucode" onchange="checkFile()" required>
                                        <label class="custom-file-label" for="validatedCustomFile">Choose file...</label>
                                        <div class="invalid-feedback">Upload your code here</div>
                                      </div>
                                </div>    
                            </div>
                                <div class="row">
                                <div class="col-1">
                                    <br/><br/>
                                     <!-- Button trigger modal -->
                                     <button id="submit" type="button" class="btn btn-primary" data-toggle="modal" data-target="#warn">
                                      Submit
                                    </button>

                                    <!-- Modal -->
                                    <div class="modal fade" id="warn" tabindex="-1" role="dialog" aria-labelledby="warn1" aria-hidden="true">
                                      <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                          <div class="modal-header">
                                            <h5 class="modal-title" id="watn1">Re-check</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                              <span aria-hidden="true">&times;</span>
                                            </button>
                                          </div>
                                          <div class="modal-body">
                                            Are you sure for submission ?
                                          </div>
                                          <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                            <button type="submit" class="btn btn-primary">Yes</button>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                </div>    
                            </div>
                            </form>
                </div>
              
    </body>
</html>
