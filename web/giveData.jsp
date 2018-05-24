<%-- 
    Document   : giveData
    Created on : 9 Apr, 2018, 12:37:37 AM
    Author     : brizz
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="com.oj.domain.Submissions"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
                    SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
                    Session s=sf.openSession();
                    Criteria cr= s.createCriteria(Submissions.class);
                    cr.addOrder(Order.desc("submissionid"));
                    List<Submissions> subs=cr.list();
                    String uid=(String)request.getParameter("uid");
                    if(uid == null)
                        uid="ALL";
                     String pcode=(String)request.getParameter("id");
                                          if(pcode == null)
                                              pcode="ALL";
                     String c=(String)request.getParameter("c");
                     int count=10;
                     if(c!= null)
                         count=Integer.parseInt(c);
                     String p=(String)request.getParameter("p");
                     int pageno=0;
                     if(p != null)
                     pageno=Integer.parseInt(p);
                    
                     List<Submissions> slist=new ArrayList<>();
                     for(Submissions su:subs)
                     {
                         String uname=(String)su.getUser().getUsername();
                         String pcode_db=(String)su.getProblems().getProblemcode();
                          if(pcode.equals("ALL") || pcode.equals(pcode_db)){
                                              if(uid.equals("ALL") || uid.equals(uname) ){
                                              
                                              slist.add(su);
                                              }}
                                              
                         
                     }
                     
                     
                    
          %>
         
                    
                  
                    <div class="row">
                        <div class="col-9">
                            <table class="table table-hover">
                                <thead class="thead-light">
                                  <tr>
                                    <th scope="col">User</th>
                                    <th scope="col">Time</th>
                                    <th scope="col">Verdict</th>
                                    <% if(pcode.equals("ALL")) {%>
                                    <th scope="col">Problem</th><% } %>
                                    <th scope="col">Language</th> 
                                    <th scope="col">Solution</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <%
                                    
                                      for(int i=(pageno*count);(i-pageno*count) < count;i++)
                                      {
                                          //response.getWriter().println(i);
                                          if(i >= slist.size())
                                              break;
                                          Submissions su=slist.get(i);
                                        
                                          String uuname=(String)request.getParameter("user");
                                         
                                          String pcode_db=(String)su.getProblems().getProblemcode();
                                          String sid=su.getSubmissionid().toString();
                                          String uname=(String)su.getUser().getUsername();
                                          String ver=(String)su.getVerdict();
                                          String time=su.getTimetaken()+"";
                                          File ucode=null;
                                          pcode=pcode.toUpperCase();
                                          ucode= new File(request.getContextPath()+"/Usercode/"+pcode_db+"."+su.getLan());                                          
                                          String date=ucode.lastModified()+"";
                                          String lan=ucode.getName().substring(ucode.getName().lastIndexOf(".")+1);
                                          String cname=sid+"."+su.getLan();
                                         
                                        %>
                                                <tr>
                                                     <td scope="row"><a href="${pageContext.request.contextPath}/profile.jsp?id=<%=uname%>"><%=uname%></a></td>
                                                    <td scope="row"><%=time%></td>
                                                    <% if(ver.equals("AC")){ %>  
                                                    <td scope="row"><center><span class="oi oi-check" title="Correct Answer" style="color: #34ce57"></span></center></td>
                                                    <% } else if(ver.equals("WA")){ %>
                                                    <td scope="row"><center><span class="oi oi-x" title="Wrong Answer" style="color: red"></span></center></td>
                                                    <% } else if(ver.equals("TLE")){ %>
                                                    <td scope="row"><center><span class="oi oi-clock" title="Timeout" style="color: red"></span></center></td>
                                                    <% } else if(ver.equals("RTE")) { %>
                                                    <td scope="row"><center><span class="oi oi-warning" title="Runtime Error" style="color: red"></span></center></td>
                                                    <% } else if(ver.equals("CTE")) { %>
                                                    <td scope="row"><center><span class="oi oi-warning" title="Compile Error" style="color: #ffc107"></span></center></td>
                                                    <% } %>
                                                    <% if(pcode.equals("ALL")) {%>
                                                    <td scope="row"><center><%=pcode_db%></center></td> <% } %>
                                                    <td scope="row"><center><%=lan.toUpperCase() %></center></td>
                                                    <td scope="row"><a href="${pageContext.request.contextPath}/viewsolution.jsp?id=<%=cname%>"><button type="button" class="btn btn-light">View</button></a></td>
                                                </tr>
                                          <%
                                              
                                              
                                      }
                                  %>
                                </tbody>
                            </table>
                        </div>
                    </div>
             
