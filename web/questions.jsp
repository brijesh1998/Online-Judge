<%@page import="java.util.Comparator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="com.oj.domain.Comments"%>
<%@page import="com.oj.domain.Discuss"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
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
        <link href="${pageContext.request.contextPath}/style/icons/font/css/open-iconic-bootstrap.css" rel="stylesheet">
    </head>
    <body onload="allow()">
        <jsp:useBean id= "stl" scope= "page" class= "com.oj.beans.SetToListBean" type= "com.oj.beans.SetToListBean"></jsp:useBean>
        <% 
             String user=(String)session.getAttribute("curruser");
             String role=(String)session.getAttribute("role");
             
             if(role.equals("admin"))
             user="admin";
             
             String id=(String)request.getParameter("id");
             if(id == null)
             response.sendRedirect(request.getContextPath()+"/discuss.jsp");
             
             SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
             Session s=sf.openSession();
             
             Discuss d=(Discuss)s.get(Discuss.class,Long.parseLong(id));
             Set<Comments> cmts=d.getCommentses();
             
             List<Comments> clist=stl.doIt(cmts);
            
        %>
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
         <script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
         <script src="https://cdn.ckeditor.com/4.9.0/standard/ckeditor.js"></script>
         <script>
            
             function callIt(method,page,cid){
                    var xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange=function() {
                      if (this.readyState == 4 && this.status == 200) {
                          if(this.responseText == "done")
                          {
                              location.reload();
                          }
                      }
                    };

                    xhttp.open(method, "${pageContext.request.contextPath}/"+page+"?id="+cid, true);
                    xhttp.send();
               }
                function approve(cid) {
                    callIt("GET","postans",cid);
                 
                  }
                function upvote(cid) {
                    
                   callIt("GET","savevote",cid);
                  }
                  function downvote(cid) {
                    
                    callIt("POST","savevote",cid);
                  }
               
               function allow() {
                   
                   if(<%=user%> == null){
                   document.getElementById("postans").innerHTML = "<i>Please login to post answer</i>";
                    }
               };
             
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
                    <div class="col">
                         <div class="card">
                          <div class="card-header">
                        <h4><%=d.getTitle() %></h4>
                        <hr/>
                        <div class="row">
                            <div class="col">
                                 <%=d.getBody() %>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col"></div><div class="col"></div>
                            <div class="col align-self-end">
                                <table>
                                    <tr>
                                        <td rowspan="2">
                                            <img height="50px" width="50px" src="${pageContext.request.contextPath}/Userdata/<%=d.getUser().getUsername()%>.png" onerror="this.src='${pageContext.request.contextPath}/Userdata/default.png'"/>
                                            &nbsp;
                                        </td>
                                        <td><a href="${pageContext.request.contextPath}/profile.jsp?id=<%=d.getUser().getUsername()%>"><%=d.getUser().getUsername()%></a></td>
                                    </tr>
                                    <tr>
                                        <td> <%=d.getDatetime() %></td>
                                    </tr>
                                </table>
                                
                            </div>
                        </div>
                          </div>
                         </div>
                        <hr/>
                        <h5>Answers</h5>
                        <hr style="border-top: dotted 1px;" />
                        <%
                            if(cmts.size() == 0){%> <i>No Answers</i> <% }
                            for(Comments c:clist){ if(c.isApproved()) { %>
                             <div class="alert alert-success" role="alert"> <% }else{ %>
                                 <div class="alert alert-secondary" role="alert"> <% } %>
                            <div class="row">
                                <div class="col">
                                   
                                    <%=c.getBody() %>
                                   
                                    
                                </div>
                                  
                            </div>
                           <div class="row">
                            <div class="col"><br/><br/><%if(c.isApproved()) { %><span class="oi oi-check"></span> <% } %></div>
                            <div class="col"><br/><br/>
                                <c:if test="${sessionScope.curruser != null}">
                                <span class="oi oi-chevron-top" onclick="upvote(<%=c.getId()%>)"></span>
                                <b id="upcount"> <%=stl.giveCount(c.getId()) %> </b>
                                <span class="oi oi-chevron-bottom" onclick="downvote(<%=c.getId()%>)"></span>
                                </c:if>
                            </div>
                            <div class="col align-self-end">
                                <table>
                                    <tr>
                                        <td rowspan="2">
                                            <img height="50px" width="50px" src="${pageContext.request.contextPath}/Userdata/<%=c.getUser().getUsername()%>.png" onerror="this.src='${pageContext.request.contextPath}/Userdata/default.png'"/>
                                            &nbsp;
                                        </td>
                                        <td><a href="${pageContext.request.contextPath}/profile.jsp?id=<%=c.getUser().getUsername()%>"><%=c.getUser().getUsername()%></a></td>
                                    </tr>
                                    <tr>
                                        <td> <%=c.getDatetime() %></td>
                                    </tr>
                                    <c:if test="${sessionScope.role == 'admin'}">
                                    <tr>
                                        <td colspan="2">
                                             <button id="approve" name="approve" value="<%=c.getId()%>" onclick="approve(<%=c.getId()%>)" class="btn btn-light"><% if(!c.isApproved()){ %>Approve<% }else{%>Disapprove<% } %></button>
                                  
                                        </td>
                                    </tr>
                                    </c:if>
                                </table>
                                
                            </div>
                        </div>
                                    
                    </div>
                                       
                                  <!--  <div id="" class="alert alert-warning alert-danger fade show" role="alert" style="display:none">
                                        <strong>Error !</strong> Please login first to give vote.
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                          <span aria-hidden="true">&times;</span>
                                        </button>
                                      </div> -->
                      <%  } %>
                      <hr/>
                      <h5>Write Answer</h5>
                      <hr style="border-top: dotted 1px;" />
                      <form method="post" action="${pageContext.request.contextPath}/postans?id=<%=d.getQuestionid()%>">
                      <div class="row">
                          <div class="col" id="postans">
                              <div class="form-group">
                                    <textarea class="form-control" rows="2" id="cbody" name="cbody" ></textarea>
                              </div>
                              <script>
                                CKEDITOR.replace( 'cbody' );
                              </script>
                              
                               <button  type="submit" name="ans" id="ans" class="btn btn-primary">Post Answer</button>
                          </div>
                      </div>
                      </form>
                    </div>
                   <!-- <div class="col-4"></div>
                    -->
                </div>
             
            </div>
             </div>
             </div>
         
    </body>
</html>