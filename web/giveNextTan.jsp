<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="com.oj.domain.Discuss"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="com.oj.domain.Submissions"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
 
       
<%
                    int q_per_page=10;
                    String num=(String)request.getParameter("num");
                    if(num != null)
                    q_per_page=Integer.parseInt(num);
                    SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
                    Session s=sf.openSession();
                    Criteria cr= s.createCriteria(Discuss.class);
                    cr.addOrder(Order.desc("questionid"));
                    List<Discuss> dis=cr.list();
                    String pcode=(String)request.getParameter("tot");
                                          if(pcode == null)
                                              pcode="0";
                   int tot=Integer.parseInt(pcode);
                   
          %>
         
                <% for(int i=(tot*q_per_page);(i-tot*q_per_page)<q_per_page;i++){ 
                    if(i >= dis.size())
                    break;
                %>
                    
                <h3><a href="${pageContext.request.contextPath}/questions.jsp?id=<%=dis.get(i).getQuestionid()%>"><%=dis.get(i).getTitle() %></a></h3>
                <div class="row">
                    <div class="col"></div><div class="col"><br/>Answers: <%=dis.get(i).getCommentses().size() %></div>
                    <div class="col">
                     
                        <table>
                                    <tr>
                                        <td rowspan="2">
                                            <img height="50px" width="50px" src="${pageContext.request.contextPath}/Userdata/<%=(dis.get(i).getUser() == null)?"Admin":dis.get(i).getUser().getUsername() %>.png" onerror="this.src='${pageContext.request.contextPath}/Userdata/default.png'"/>
                                            &nbsp;
                                        </td>
                                        <td><a href="${pageContext.request.contextPath}/profile.jsp?id=<%=(dis.get(i).getUser() == null)?"Admin":dis.get(i).getUser().getUsername() %>"><%=(dis.get(i).getUser() == null)?"Admin":dis.get(i).getUser().getUsername() %></a></td>
                                    </tr>
                                    <tr>
                                        <td>  <%=dis.get(0).getDatetime() %></td>
                                    </tr>
                                </table>          
                    </div>
                </div>
                
                
                <hr/>
                
                <%}%>
            