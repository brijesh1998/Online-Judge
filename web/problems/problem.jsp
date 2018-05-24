


<%@page import="com.oj.domain.Problems"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.FileReader"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.net.URL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.min.css">
        <link href="${pageContext.request.contextPath}/style/icons/font/css/open-iconic-bootstrap.css" rel="stylesheet">
        <%
                String role=(String)session.getAttribute("role");
            
                String pcode=null,pstmt=null,pinput=null,poutput=null,pconstrains=null,des=null,tcin=null,tcout=null,explain=null,ptime=null,pmem=null,psetter=null,pname=null;
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
    </head>
    <body>
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
         <script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
         <script>
             var inter= setInterval(loadDoc, 1000);
             var p=0;
        function loadDoc() {
              var xhttp = new XMLHttpRequest();
              xhttp.onreadystatechange=function() {
                if (this.readyState == 4 && this.status == 200) {
                  document.getElementById("datade").innerHTML = this.responseText;
                }
              };
              xhttp.open("GET", "${pageContext.request.contextPath}/giveData.jsp?id=<%=pcode%>&c=10&p="+p, true);
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
                <c:if test="${sessionScope.curruser != null and sessionScope.role == 'user'}">
                    <jsp:include page="/navbars/logoutnav.jsp" />
                </c:if>
                <c:if test="${sessionScope.curruser != null and sessionScope.role == 'admin'}">
                    <jsp:include page="/navbars/adminnav.jsp" />
                </c:if>
            </div>
     </div>
         <br/><br/>
         <div class="container">
             <div class="card">
                <div class="card-body">
                        <div class="row">
                        <div class="col-10"><font size="8"><b><%=pname%></b></font> &nbsp;&nbsp;| &nbsp;&nbsp; Problem Code: <%=code%></div>
                        <%
                            session.setAttribute("probtosolve",code);
                        %>
                        <div class="col-2"><br/>
                            <c:if test="${sessionScope.role == 'user'}">
                            <a href="${pageContext.request.contextPath}/problems/submit.jsp"><button type="button" class="btn btn-primary">Submit</button></a>
                            </c:if>
                            <c:if test="${sessionScope.role == 'admin'}">
                                <p>Visible: <%= ((vis)?"Yes":"No")%></p>
                            <a href="${pageContext.request.contextPath}/admin/editproblem.jsp?id=<%=pcode%>"><button type="button" class="btn btn-primary">Edit</button></a>    
                            </c:if>
                            </div>
                    </div>
                   <hr style="height:1px;border:none;color:#333;background-color:#333;" />
                   <div class="row">
                       <div class="col-7">
                           <div class="row">
                               <div class="col">
                                   <%=pstmt%>
                                  
                                    </div>
                           </div>
                           <hr style="height:1px;border:none;color:#333;background-color:#333;" />
                           <font size="4"><b>Input</b></font>
                           <div class="row">
                               <div class="col">
                                   <%=pinput%>
                                  
                               </div>
                           </div>
                            <hr style="height:1px;border:none;color:#333;background-color:#333;" />
                           <font size="4"><b>Output</b></font>
                           <div class="row">
                               <div class="col">
                                   <%=poutput%>
                                   
                               </div>
                           </div>
                           <hr style="height:1px;border:none;color:#333;background-color:#333;" />
                           <font size="4"><b>Constraints</b></font>
                           <div class="row">
                               <div class="col">
                                   <%=pconstrains%>
                               </div>
                           </div>
                           <hr style="height:1px;border:none;color:#333;background-color:#333;" />
                           <font size="4"><b>Example</b></font>
                           <div class="row">
                               <div class="col">
                                    <div class="row">
                                        <div class="col">
                                           <p><b>Input</b></p>
                                           <%=tcin%>
                                        </div>
                                    </div>
                                   <div class="row">
                                        <div class="col">
                                            <p><b>Output</b></p>
                                           <%=tcout%>
                                        </div>
                                    </div>
                               </div>
                           </div>
                           <hr style="height:1px;border:none;color:#333;background-color:#333;" />
                           <font size="4"><b>Expaination</b></font>
                           <div class="row">
                               <div class="col">
                                    <%=explain%>
                               </div>
                           </div>



                           <div class="row">
                               <div class="col">
                                   <div class="card bg-light text-dark">
                               <div class="card-body">
                                   <div class="row">
                                        <div class="col-3">
                                        <b>Setter:</b>
                                        </div>
                                        <div class="col">
                                            <%=psetter%>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-3">
                                        <b>Time Limit:</b>
                                        </div>
                                        <div class="col">
                                            <%=ptime%> sec
                                        </div>
                                    </div>
                                        <div class="row">
                                        <div class="col-3">
                                        <b>Memory Limit:</b>
                                        </div>
                                        <div class="col">
                                            <%=pmem%> megabytes
                                        </div>
                                    </div>
                                        <div class="row">
                                        <div class="col-3">
                                        <b>Languages:</b>
                                        </div>
                                        <div class="col">
                                            C, C++, JAVA, python3
                                        </div>
                                    </div>
                               </div>
                           </div>

                               </div>
                           </div>
                           <div class="row">
                               <div class="col"><br/>
                                   <center>
                                 <c:if test="${sessionScope.role == 'user'}">
                                    <a href="${pageContext.request.contextPath}/problems/submit.jsp"><button type="button" class="btn btn-primary">Submit</button></a>
                                    </c:if>
                                    <c:if test="${sessionScope.role == 'admin'}">
                                    <a href="${pageContext.request.contextPath}/admin/editproblem.jsp?id=<%=pcode%>"><button type="button" class="btn btn-primary">Edit</button></a>    
                                    </c:if>
                                   </center>
                               </div>
                           </div>
                       </div>
                                        <div class="col-5"><center>
                                            <div id="datade" style="overflow-x: auto">
                                                <div class="progress" style="height: 25px">
                                                    <div id="bar" class="progress-bar progress-bar-striped progress-bar-animated " role="progressbar" aria-valuenow="100"  aria-valuemin="0" aria-valuemax="100" style="width: 100%;height: 100%">
                                                        Loading...
                                                    </div>
                                                                                     </div>
                                            </div></center>
                                            <br/>
                                             <div class="row">
                        <div class="col">
                            <button id="nextp" class="btn btn-light" onclick="prevPage()">Prev</button>
                        </div>
                        <div class="col-lm">
                            <button  id="prevp" class="btn btn-light" onclick="nextPage()">Next</button>
                        </div>
                    </div>
                                        </div>
                                        
                   </div>
                </div>
             </div>
             
         </div>
         <br/><br/><br/>
    </body>
</html>
