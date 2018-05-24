<%-- 
    Document   : problems
    Created on : 4 Apr, 2018, 4:27:40 PM
    Author     : brizz
--%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.FileReader"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.util.List"%>
<%@page import="com.oj.domain.Problems"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Problems</title>
         <link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.min.css">
         <link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
        
    </head>
    <body>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
         <script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
          
          <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
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
             $(document).ready(function() {
                $('#example').DataTable();
            } );
          </script>
          <jsp:useBean id= "stl" scope= "page" class= "com.oj.beans.SetToListBean" type= "com.oj.beans.SetToListBean"></jsp:useBean>
                <%
                     String role=(String)session.getAttribute("role");
                     
                    SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
                    Session s=sf.openSession();
                    Criteria cr= s.createCriteria(Problems.class);
                    List<Problems> pl=cr.list();
                %>
         <div class="container">
             <div class="container">
 
                <br>
                
                <ul class="nav nav-pills" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" data-toggle="pill" href="#easy">Easy</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" data-toggle="pill" href="#medium">Medium</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" data-toggle="pill" href="#hard">Hard</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" data-toggle="pill" href="#expert">Expert</a>
                  </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                  <div id="easy" class="container tab-pane active"><br>
                      <table id="example" class="table table-hover" style="width:100%">
                        <thead class="thead-light">
                            <tr>
                                <th>Title</th>
                                <th>Problem Code</th>
                                <th>Successful Submission</th>
                                <c:if test="${sessionScope.role == 'admin'}">
                                    <th>Visible</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <% int easy=0;
                                for(Problems p:pl)   
                            {
                               
                                String pcode=(String)p.getProblemcode();
                                String diff=(String)p.getDifficulty();
                                boolean vis=p.isVisibletoall();
                                String pname=null;
                                if((vis && role.equals("norole")) || (vis && role.equals("user")) || role.equals("admin"))
                                if(diff.equals("easy")){
                                try{easy++;
                                    String webpath=(String)request.getServletContext().getAttribute("webpath");
                                    JSONParser parser = new JSONParser();
                                    JSONObject pjo=(JSONObject) parser.parse(new FileReader(webpath+"/problems/pstmts.json"));
                                    JSONObject jo=(JSONObject)parser.parse(pjo.get(pcode).toString());
                                    pname=jo.get("pname").toString();
                                    }
                                catch(Exception e)
                                {}
                                
                                
                            %>
                            <tr>
                                <td><a href="${pageContext.request.contextPath}/problems/problem.jsp?id=<%=pcode%>"><%=pname%></a></td>
                                <td><a href="${pageContext.request.contextPath}/problems/problem.jsp?id=<%=pcode%>"><%=pcode%></a></td>  
                                <td><a href="${pageContext.request.contextPath}/submissions.jsp?id=<%=pcode%>"><%=stl.countSub(pcode) %></a></td>
                               <c:if test="${sessionScope.role == 'admin'}">
                                    <td><%= ((vis)?"Yes":"No")%></td>
                                </c:if>
                            </tr>
                            <%}}
                            if(easy == 0)
                            {%>
                            <tr>
                                <td colspan="3">No Problems</td>
                                </tr>
                            <%}%>
                        </tbody>
                            
                        <tfoot>
                            <tr>
                                <th>Title</th>
                                <th>Problem Code</th>
                                <th>Successful Submission</th>
                                <c:if test="${sessionScope.role == 'admin'}">
                                    <th>Visible</th>
                                </c:if>
                            </tr>
                        </tfoot>
    </table>
                  </div>
                  <div id="medium" class="container tab-pane fade"><br>
                      <table id="example" class="table table-hover" style="width:100%">
                        <thead class="thead-light">
                            <tr>
                                <th>Title</th>
                                <th>Problem Code</th>
                                <th>Successful Submission</th>
                                <c:if test="${sessionScope.role == 'admin'}">
                                    <th>Visible</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <% int medium=0;
                                for(Problems p:pl)   
                            {
                                String pcode=(String)p.getProblemcode();
                                String diff=(String)p.getDifficulty();
                                boolean vis=p.isVisibletoall();
                                String pname=null;
                                 if((vis && role.equals("norole")) || (vis && role.equals("user")) || role.equals("admin"))
                                if(diff.equals("medium")){
                                try{medium=0;
                                    String webpath=(String)request.getServletContext().getAttribute("webpath");
                                    JSONParser parser = new JSONParser();
                                    JSONObject pjo=(JSONObject) parser.parse(new FileReader(webpath+"/problems/pstmts.json"));
                                    JSONObject jo=(JSONObject)parser.parse(pjo.get(pcode).toString());
                                    pname=jo.get("pname").toString();
                                    }
                                catch(Exception e)
                                {}
                                
                                
                            %>
                            <tr>
                                <td><a href="${pageContext.request.contextPath}/problems/problem.jsp?id=<%=pcode%>"><%=pname%></a></td>
                                <td><a href="${pageContext.request.contextPath}/problems/problem.jsp?id=<%=pcode%>"><%=pcode%></a></td>  
                                <td><a href="${pageContext.request.contextPath}/submissions.jsp?id=<%=pcode%>"><%=stl.countSub(pcode)%></a></td>
                                <c:if test="${sessionScope.role == 'admin'}">
                                    <td><%= ((vis)?"Yes":"No")%></td>
                                </c:if>
                            </tr>
                            <%}}
                            if(medium == 0)
                            {%>
                            <tr>
                                <td colspan="3">No Problems</td>
                                </tr>
                            <%}%>
                        </tbody>
        
                        <tfoot>
                            <tr>
                                <th>Title</th>
                                <th>Problem Code</th>
                                <th>Successful Submission</th>
                                <c:if test="${sessionScope.role == 'admin'}">
                                    <th>Visible</th>
                                </c:if>
                            </tr>
                        </tfoot>
                    </table>
                  </div>
                  <div id="hard" class="container tab-pane fade"><br>
                   <table id="example" class="table table-hover" style="width:100%">
                        <thead class="thead-light">
                            <tr>
                                <th>Title</th>
                                <th>Problem Code</th>
                                <th>Successful Submission</th>
                                <c:if test="${sessionScope.role == 'admin'}">
                                    <th>Visible</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <% int hard=0;
                                for(Problems p:pl)   
                            {
                                String pcode=(String)p.getProblemcode();
                                String diff=(String)p.getDifficulty();
                                boolean vis=p.isVisibletoall();
                                String pname=null;
                                
                                 if((vis && role.equals("norole")) || (vis && role.equals("user")) || role.equals("admin"))
                                if(diff.equals("hard")){
                                try{hard=0;
                                    String webpath=(String)request.getServletContext().getAttribute("webpath");
                                    JSONParser parser = new JSONParser();
                                    JSONObject pjo=(JSONObject) parser.parse(new FileReader(webpath+"/problems/pstmts.json"));
                                    JSONObject jo=(JSONObject)parser.parse(pjo.get(pcode).toString());
                                    pname=jo.get("pname").toString();
                                    }
                                catch(Exception e)
                                {}
                                
                                
                            %>
                            <tr>
                                <td><a href="${pageContext.request.contextPath}/problems/problem.jsp?id=<%=pcode%>"><%=pname%></a></td>
                                <td><a href="${pageContext.request.contextPath}/problems/problem.jsp?id=<%=pcode%>"><%=pcode%></a></td>  
                                <td><a href="${pageContext.request.contextPath}/submissions.jsp?id=<%=pcode%>"><%=stl.countSub(pcode)%></a></td>
                                <c:if test="${sessionScope.role == 'admin'}">
                                     <td><%= ((vis)?"Yes":"No")%></td>
                                </c:if>
                            </tr>
                            <%}}
                            if(hard == 0)
                            {%>
                            <tr>
                                <td colspan="3">No Problems</td>
                                </tr>
                            <%}%>
                        </tbody>
        
                        <tfoot>
                            <tr>
                                <th>Title</th>
                                <th>Problem Code</th>
                                <th>Successful Submission</th>
                                <c:if test="${sessionScope.role == 'admin'}">
                                    <th>Visible</th>
                                </c:if>
                            </tr>
                        </tfoot>
                    </table>
                  </div>
                   <div id="expert" class="container tab-pane fade"><br>
                    <table id="example" class="table table-hover" style="width:100%">
                        <thead class="thead-light">
                            <tr>
                                <th>Title</th>
                                <th>Problem Code</th>
                                <th>Successful Submission</th>
                                <c:if test="${sessionScope.role == 'admin'}">
                                    <th>Visible</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <% int expert=0;
                                for(Problems p:pl)   
                            {
                                String pcode=(String)p.getProblemcode();
                                String diff=(String)p.getDifficulty();
                                boolean vis=p.isVisibletoall();
                                String pname=null;
                                 if((vis && role.equals("norole")) || (vis && role.equals("user")) || role.equals("admin"))
                                if(diff.equals("expert")){
                                try{expert=0;
                                    String webpath=(String)request.getServletContext().getAttribute("webpath");
                                    JSONParser parser = new JSONParser();
                                    JSONObject pjo=(JSONObject) parser.parse(new FileReader(webpath+"/problems/pstmts.json"));
                                    JSONObject jo=(JSONObject)parser.parse(pjo.get(pcode).toString());
                                    pname=jo.get("pname").toString();
                                    }
                                catch(Exception e)
                                {}
                                
                                
                            %>
                            <tr>
                                <td><a href="${pageContext.request.contextPath}/problems/problem.jsp?id=<%=pcode%>"><%=pname%></a></td>
                                <td><a href="${pageContext.request.contextPath}/problems/problem.jsp?id=<%=pcode%>"><%=pcode%></a></td>  
                                <td><a href="${pageContext.request.contextPath}/submissions.jsp?id=<%=pcode%>"><%=stl.countSub(pcode)%></a></td>
                                <c:if test="${sessionScope.role == 'admin'}">
                                     <td><%= ((vis)?"Yes":"No")%></td>
                                </c:if>
                            </tr>
                            <%}}
                            if(expert == 0)
                            {%>
                            <tr>
                                <td colspan="3">No Problems</td>
                                </tr>
                            <%}%>
                        </tbody>
        
                        <tfoot>
                            <tr>
                                <th>Title</th>
                                <th>Problem Code</th>
                                <th>Successful Submission</th>
                                <c:if test="${sessionScope.role == 'admin'}">
                                    <th>Visible</th>
                                </c:if>
                            </tr>
                        </tfoot>
                    </table>
                  </div>
                </div>
              </div>

         </div>
         
    </body>
</html>
