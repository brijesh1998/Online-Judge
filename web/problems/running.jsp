<%-- 
    Document   : index
    Created on : 24 Mar, 2018, 2:21:17 PM
    Author     : brizz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Running...</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.min.css">
  
    </head>
    <body>
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
         <script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
         
        <script>
            function getParam(name){
                if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search))
                return decodeURIComponent(name[1]);
            }
            
           var inter= setInterval(loadDoc, 500);
            
            function loadDoc() {
              var xhttp = new XMLHttpRequest();
              xhttp.onreadystatechange=function() {
                if (this.readyState == 4 && this.status == 200) {
                    if(this.responseText == "done"){
                        clearInterval(inter);
                    document.getElementById("con").style.visibility = "hidden";
                    var ctx = "${pageContext.request.contextPath}";
                    var id=getParam("id");
                    window.location.replace(ctx+"/problems/verdict.jsp?sid="+id);
                        }
                  document.getElementById("bar").innerHTML = this.responseText;
                }
              };
              xhttp.open("GET", "../submit", true);
              xhttp.send();
            }
            function called(){
                document.getElementById("lll").style.visibility = "hidden";
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
            <p id="demo"></p>
           
                <div id="con" class="container">
              <h2>Processing...</h2>
               
              <div class="progress" style="height: 25px">
                  <div id="bar" class="progress-bar progress-bar-striped progress-bar-animated " role="progressbar" aria-valuenow="100"  aria-valuemin="0" aria-valuemax="100" style="width: 100%;height: 100%">
                      In Queue...
                  </div>
                  </div>
            </div>
            
              
    </body>
</html>
