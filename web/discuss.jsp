<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Discuss</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.min.css">
  
    </head>
    <body>
        <% 
             String user=(String)session.getAttribute("curruser");
             String role=(String)session.getAttribute("role");
             
             if(role.equals("admin"))
             user="admin";
                     %>
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
         <script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
         <script src="https://cdn.ckeditor.com/4.9.0/standard/ckeditor.js"></script>
          <script>
              
              var tot=0;
              var num=10;
             
              
            function loadDoc() {
              var xhttp = new XMLHttpRequest();
              xhttp.onreadystatechange=function() {
                if (this.readyState == 4 && this.status == 200) {
                    if(!$.trim(this.responseText)){
                        prev();
                                    }
                        
                  document.getElementById("datade").innerHTML = this.responseText;
                }
              };
              
              xhttp.open("GET", "${pageContext.request.contextPath}/giveNextTan.jsp?tot="+tot+"&num="+num, true);
              xhttp.send();
            }
            loadDoc();
            function next(){
                
               tot++;
                 loadDoc();
            }
            function prev(){
              tot--;
              if(tot<0)tot=0;
                        loadDoc();
            }
            function changeIt(){
                
                num=document.getElementById("num").value;
                loadDoc();
            }
            function check(){
                if(<%=user%> == null)
                {
                    document.getElementById("ask").innerHTML = "Please Login first";
                }
             
            }
         </script>
         
         <div class="row">
            <div class="col">
                <c:if test="${sessionScope.curruser == null}">
                    <jsp:include page="/navbars/loginnav.jsp" />
                </c:if>
                <c:if test="${sessionScope.curruser != null and sessionScope.role == 'user'}">
                    <jsp:include page="/navbars/logoutnav.jsp" />
                </c:if>
                <c:if test="${sessionScope.curruser != null and sessionScope.role == 'admin'}">
                    <jsp:include page="/navbars/adminnav.jsp" />
                </c:if>
            </div>
            </div>
         <br/><br/><br/>
         <div class="container">
             <p id="lol"></p>
             <c:if test="${param.msg == 'done'}">
                 <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong>Added !</strong> Your Question is added in discussion.
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
             </c:if>
             <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-3">
                        <h2>Discussion</h2>
                    </div>
                    <div class="col-6"></div>
                    <div class="col-3"></div>
                </div>
                 <hr style="height:1px;border:none;color:#333;background-color:#333;" />
                <div class="row">
                    <div class="col-8">
                        
                        <ul class="nav nav-pills">
                            <li class="nav-item">
                              <a class="nav-link active" data-toggle="pill" href="#que">Questions</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="pill" onclick="check()" href="#ask">Ask a question</a>
                            </li>
                            
                          </ul>
                            <hr style="height:1px;border:none;color:#333;background-color:#333;" />
                          <!-- Tab panes -->
                          <div class="tab-content">
                              <div class="tab-pane active container" id="que">
                                  <div class="row">
                                      <div class="col">
                                          <div id="datade"></div>
                                            <div id="ppage">
                                                <div class="row">
                                                    <div class="col">
                                                    <nav aria-label="Page navigation example">
                                                        <ul class="pagination justify-content-center">
                                                            <li class="page-item"><a class="page-link" onclick="prev()" href="#">Previous</a></li>

                                                          <li class="page-item"><a class="page-link" onclick="next()" href="#">Next</a></li>
                                                        </ul>
                                                    </nav>
                                                    </div>
                                                     <div class="col-2">
                                                         <input type="number" class="form-control" id="num" placeholder="Items" name="num">
                                                        </div>
                                                    <div class="col-1">
                                                        <button type="button" onclick="changeIt()" class="btn btn-outline-primary">Go</button>
                                                    </div>
                                                </div>
                                            
                                            </div>
                                       </div>
                                     
                                  </div>
                                  
                              </div>
                              <div class="tab-pane container" id="ask">
                                   <form method="post" action="${pageContext.request.contextPath}/askQue">
                                       <div class="row">
                                            <div class="col-2">
                                                <p><b>Title</b></p>
                                            </div>
                                            <div class="col-4">
                                                 <div class="form-group">
            
                                                     <input type="text" class="form-control" id="title" name="title" placeholder="Title" required/>
                                                </div>
                                            </div>
                                             
                                        </div>
                                        
                                                <div class="row">
                                            <div class="col-2">
                                                <p><b>Body</b></p>
                                            </div>
                                            <div class="col-10">
                                                 <div class="form-group">
                                                     <textarea class="form-control" rows="2" id="qbody" name="qbody" ></textarea>
                                                </div>
                                               <script>
                                                    CKEDITOR.replace( 'qbody' );
                                                </script>
                                            </div>
                                        </div>
                                         <div class="row">
                                            <div class="col">
                                                <center> <button  type="submit" name="ask" id="ask" class="btn btn-primary">Ask</button></center>
                                            </div>
                                            </div>
                                   </form>
                              </div>
                            
                          </div>
                        
                    </div>
                    <dic class="col-4"></dic>
                    
                </div>
             
            </div>
             </div>
             </div>
         
    </body>
</html>