<%-- 
    Document   : verdict
    Created on : 16 Mar, 2018, 12:57:06 AM
    Author     : brizz
--%>

<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.FileReader"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.oj.domain.Result"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.min.css">
    </head>
    <body>
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
         <script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
         <script>
                        function myFunction(c) {
                           if(c == 1)
                                $('#warn').modal('show'); 
                            if(c == 2)
                                $('#warn').modal('hide');
                           
            }            
            
           
                    </script>
   
         <div class="row">
            <div class="col">
               
                    <%
                        String appurl=(String)request.getServletContext().getAttribute("appurl");
                        String probtosolve=(String)session.getAttribute("probtosolve");
                        String curruser=(String)session.getAttribute("curruser");
                        
                        if(curruser == null)
                        {%>
                        <script>
                            myFuction(2);
                        </script><%
                        }
                        else{%>
                        <script>
                            myFuction(1);
                        </script><%
                        }

                      //  out.print(curruser);
                        %>
                         <div class="modal fade" id="warn" tabindex="-1" role="dialog" aria-labelledby="warn1" aria-hidden="true">
                                      <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                          <div class="modal-header">
                                            <h5 class="modal-title" id="watn1">Error</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                              <span aria-hidden="true">&times;</span>
                                            </button>
                                          </div>
                                          <div class="modal-body">
                                            Something Wrong !
                                          </div>
                                         
                                        </div>
                                      </div>
                                    </div>
                       
                 <c:if test="${sessionScope.curruser == null}">
                    
                    
                </c:if>
                <c:if test="${sessionScope.curruser != null}">
                   
                    <jsp:include page="../navbars/logoutnav.jsp" />
                </c:if>
                <div class="container">
                    <br/><br/>
                    <%
                                String sid=request.getParameter("sid");
                                String c=(String)session.getAttribute("isdone");
                                String webpath=(String)request.getServletContext().getAttribute("webpath");
                                JSONParser parser = new JSONParser();
                                JSONObject pjo=(JSONObject) parser.parse(new FileReader(webpath+"/Usercode/Submissions/results.json"));
                                JSONArray json = (JSONArray) parser.parse((String)pjo.get(sid));
                                Gson gson = new Gson();
                                Type type = new TypeToken<List<Result>>() {}.getType();
                                List<Result> res=gson.fromJson(json.toString(), type);
                                if(res == null)
                                    c="cte";
                                
                                else if(res.size() >= 1)
                                {
                                    if(res.get(0).result.equals("CTE"))
                                        c="cte";
                                    else
                                        c="ok";
                                }
                              //  String c="cte";
                            //  out.print(c + " "+res.toString());
                              if(c !=null){
                                if(c.equals("cte"))
                                {%>
                                  <div class="alert alert-danger">
                                    <strong>Compile error</strong> CTE due to some syntax error.
                                    </div>   
                                <%}
                                }
                            %>
                            
                <br/><br/>
                    <div class="row">
                        <div class="col-1"></div>
                    <div class="col-10">
                        <table class="table">
                            <%
                                if(c.equals("ok"))
                                {%>
                                    <thead class="thead-dark">
                              <tr>
                                <th scope="col">Case #</th>
                                <th scope="col">Time</th>
                               <!-- <th scope="col">Memory</th> -->
                                <th scope="col">Result</th>
                                
                              </tr>
                            </thead>
                                <%}
                            %>
                            
                            <%
                                int num=0;
                                if(res != null && c.equals("ok"))
                                for(Result ans:res)
                                {
                                    num++;
                                    if(ans.result.equals("AC"))
                                    {%>
                                         <tr class="table-success">
                                            <td>Case <%=num%></td>
                                            <td><%=ans.timetaken/1000.0f%></td>
                                            
                                            <td><%=ans.result%></td>
                                        </tr>
                                    
                                    <%    
                                    }
                                    else
                                    {%>
                                      
                                         <tr class="table-danger">
                                            <td>Case <%=num%></td>
                                            <td><%=ans.timetaken/1000.0f%></td>
                                            
                                            <td><%=ans.result%></td>
                                        </tr>
                                    <%}
                                    
                                }
                                    
                            %>
                           
                    </div>
                        <div class="col-1"></div>
                </div>
                </div>
            </div>
         </div>
    </body>
</html>
