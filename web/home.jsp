<%-- 
    Document   : home
    Created on : 12 Mar, 2018, 1:47:16 AM
    Author     : brizz
--%>

<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Judge</title>
        <style>
            
        #snackbar {
            visibility: hidden;
            min-width: 250px;
            margin-left: -125px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 2px;
            padding: 16px;
            position: fixed;
            z-index: 1;
            right: 5%;
            top: 70px;
            font-size: 17px;
        }

        #snackbar.show {
            visibility: visible;
            -webkit-animation: fadein 1.0s, fadeout 1.0s 4.0s;
            animation: fadein 1.0s, fadeout 1.0s 4.0s;
        }

        @-webkit-keyframes fadein {
            from {top: 0; opacity: 0;} 
            to {top: 70px; opacity: 1;}
        }

        @keyframes fadein {
            from {top: 0; opacity: 0;}
            to {top: 70px; opacity: 1;}
        }

        @-webkit-keyframes fadeout {
            from {top: 70px; opacity: 1;} 
            to {top: 0; opacity: 0;}
        }

        @keyframes fadeout {
            from {top: 70px; opacity: 1;}
            to {top: 0; opacity: 0;}
        }
</style>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.min.css">
 <link href="${pageContext.request.contextPath}/style/icons/font/css/open-iconic-bootstrap.css" rel="stylesheet">
    </head>
    <body>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
    
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
        <script>
        function myFunction() {
            var x = document.getElementById("snackbar")
            x.className = "show";
            setTimeout(function(){ x.className = x.className.replace("show", ""); }, 5000);
        }
        var inter= setInterval(loadQue, 2000);
        function loadQue() {
              var xhttp = new XMLHttpRequest();
              xhttp.onreadystatechange=function() {
                if (this.readyState == 4 && this.status == 200) {
                  document.getElementById("datade").innerHTML = this.responseText;
                }
              };
              xhttp.open("GET", "./giveNextTan.jsp?tot=0", true);
              xhttp.send();
             
            }
            var inter= setInterval(loadSub, 2000);
        function loadSub() {
              var xhttp = new XMLHttpRequest();
              xhttp.onreadystatechange=function() {
                if (this.readyState == 4 && this.status == 200) {
                  document.getElementById("jaja").innerHTML = this.responseText;
                }
              };
              xhttp.open("GET", "./giveData.jsp?c=10", true);
              xhttp.send();
             
            }
        </script>
 
<c:if test="${param.msg == 'done'}">
<div id="snackbar">Successfully Registered..</div>
    <script>
        myFunction();
    </script>
</c:if>
    <c:if test="${param.msg == 'logout'}">
<div id="snackbar">Successfully Logged out..</div>
    <script>
        myFunction();
    </script>
</c:if>
        <div class="row">
            <div class="col">
        
       
            </div>
        </div>
            
            <%
                String uri = request.getRequestURI();
                String pageName = uri.substring(uri.lastIndexOf("/")+1);
               // out.println(pageName);
            %>
            <br/><br/><br/>
            <div class="container">
                <div class="card">
                    <div class="card-body">
                <div class="row">
                    
                    <div class="col-6">
                        <h3>Recent Questions</h3>
                          <hr style="height:1px;border:none;color:#333;background-color:#333;" />
                          <div id="datade">
                              <div class="progress" style="height: 25px">
                                                    <div id="bar" class="progress-bar progress-bar-striped progress-bar-animated " role="progressbar" aria-valuenow="100"  aria-valuemin="0" aria-valuemax="100" style="width: 100%;height: 100%">
                                                        Loading...
                                                    </div>
                                                                                     </div>
                          </div>
                    </div>
                    
                    <div class="col-6">
                        <h3>Recent Submissions</h3>
                          <hr style="height:1px;border:none;color:#333;background-color:#333;" />
                          <div id="jaja" style="overflow-x: auto">
                              <div class="progress" style="height: 25px">
                                                    <div id="bar" class="progress-bar progress-bar-striped progress-bar-animated " role="progressbar" aria-valuenow="100"  aria-valuemin="0" aria-valuemax="100" style="width: 100%;height: 100%">
                                                        Loading...
                                                    </div>
                                                                                     </div>
                          </div>
                    </div>
                </div>
                    </div>
                </div>
            </div>
    </body>
</html>
