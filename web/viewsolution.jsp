<%-- 
    Document   : viewsolution
    Created on : 5 Apr, 2018, 12:33:12 AM
    Author     : brizz
--%>

<%@page import="com.oj.domain.Submissions"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Solution</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.min.css">
    </head>
    <body>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js?lang=c"></script>
        <script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
       <%
           String sid=(String)request.getParameter("id");
       %>
       <jsp:useBean id= "fc" scope= "page" class= "com.oj.beans.FileBean" type= "com.oj.beans.FileBean"></jsp:useBean>
       <%
           String webpath=(String)request.getServletContext().getAttribute("webpath");
           String content=fc.getContent(webpath+"/Usercode/"+sid);
           
          /* SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
           Session s=sf.openSession();
           Submissions sub=(Submissions)s.get(Submissions.class,1130);
           String time=null;
           String user=sub.getUser().getUsername();
           String ver=sub.getVerdict();
           String tt=sub.getTimetaken()+"";
           String lan=sub.getLan();*/
           
           //out.println(webpath+sid+"\n "+content);
       %>
       <div class="row">
            <div class="col">
                <c:if test="${sessionScope.curruser == null}">
                    <jsp:include page="/navbars/loginnav.jsp" />
                </c:if>
                <c:if test="${sessionScope.curruser != null}">
                    <jsp:include page="/navbars/logoutnav.jsp" />
                </c:if>
            </div>
     </div><br/><br/><br/>
     <div class="container">
         
         <div class="card">
            <div class="card-body">
               <code class="prettyprint"><%=content%></code>
            </div>
          </div>
     </div>
      
     
    </body>
</html>
