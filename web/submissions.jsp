<%-- 
    Document   : submissions
    Created on : 4 Apr, 2018, 7:36:05 PM
    Author     : brizz
--%>

<%@page import="org.apache.commons.io.filefilter.WildcardFileFilter"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.nio.file.attribute.BasicFileAttributes"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.attribute.BasicFileAttributeView"%>
<%@page import="java.nio.file.Paths"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.File"%>
<%@page import="com.oj.domain.Submissions"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="com.oj.domain.Problems"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Submissions</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.min.css">
        <link href="${pageContext.request.contextPath}/style/icons/font/css/open-iconic-bootstrap.css" rel="stylesheet">
    </head>
    <body>
         <%
                   String pcode=(String)request.getParameter("id");
                   if(pcode == null)
                       pcode="ALL";
                   pcode=pcode.toUpperCase();
          %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
         <script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
         
         <script>
                var p=0;
              var c=15;
                var inter= setInterval(loadSub, 2000);
                var user="";
                function textChange(){
                    user=document.getElementById("user").value;
                    p=0;
                    loadDoc();
                }
                function loadSub() {
                        
                      var xhttp = new XMLHttpRequest();
                      xhttp.onreadystatechange=function() {
                        if (this.readyState == 4 && this.status == 200) {
                            if(!$.trim(this.responseText)){
                        prevPage();
                                    }
                          document.getElementById("datade").innerHTML = this.responseText;
                        }
                      };
                      if(user == "")
                        xhttp.open("GET", "./giveData.jsp?id=<%=pcode%>&c="+c+"&p="+p, true);
                       else
                           xhttp.open("GET", "./giveData.jsp?id=<%=pcode%>&uid="+user+"&c="+c+"&p="+p, true);
                      xhttp.send();

                    }
                  function nextPage(){
                      p++;
                      loadSub();
                  }
                  function prevPage(){
                      p--;
                      if(p < 0)p=0;
                      loadDoc();
                  }
         </script>
         
          <div class="row">
            <div class="col">
                <c:if test="${sessionScope.curruser == null}">
                    <jsp:include page="/navbars/loginnav.jsp" />
                </c:if>
                <c:if test="${sessionScope.curruser != null}">
                    <jsp:include page="/navbars/logoutnav.jsp" />
                </c:if>
            </div>
     </div>
          <br/><br/>
         
          <div class="container">
              <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-2">
                            <div class="form-group">
                                <input type="text" class="form-control" id="user" placeholder="Username" name="user" />
                            </div>
                        </div>
                        <div class="col">
                            <button id="go" class="btn btn-light" onclick="textChange()">Go</button>
                        </div>
                        
                    </div>
                    <hr/>
                    <div class="row">
                        <div class="col-9" id="datade">
                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <button id="nextp" class="btn btn-light" onclick="prevPage()">Prev</button>
                        </div>
                        <div class="col">
                            <button  id="prevp" class="btn btn-light" onclick="nextPage()">Next</button>
                        </div>
                    </div>
                </div>
              </div>
              </div>
    </body>
</html>
