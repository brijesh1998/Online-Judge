<%-- 
    Document   : profile
    Created on : 12 Mar, 2018, 6:50:35 PM
    Author     : brizz
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="org.hibernate.Session"%>
<%@page import="com.oj.domain.User"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            String curuser=(String)session.getAttribute("curruser");
            String webpath=(String)request.getServletContext().getAttribute("webpath");
            String title=(String)request.getParameter("id");
            if(title == null)
                title=(String)session.getAttribute("curruser");
            
            if(title == null)
            title="User Profile";
            
            SessionFactory sf=(SessionFactory)request.getServletContext().getAttribute("sf");
            Session s = sf.openSession();
                                            
            User user =  (User) s.get(User.class,title);
            
            if(user == null)
            {
                response.sendRedirect(request.getContextPath()+"/home.jsp?msg=no+user");
            }
            String uname=user.getUsername();
            String name=user.getFullname();
            String email=user.getEmail();
            String country=user.getCountry();
            String city=user.getCity();
            String state=user.getState();
            String inst=user.getInstitution();
            String link=user.getLink();
            String pos=user.getPosition();
            String motto=user.getMotto();
            String aboutme=user.getAboutme();
            int grank=0;
            int crank=0;
            int rating=0;
            
            Object o=user.getGlobelRank();
            if(o != null)
                grank=(int)o;
                
            o=user.getCountryRank();
            if(o != null)
                crank=(int)o;
            
            o=user.getRatings();
            if(o != null)
                rating=(int)o;
            
             //   out.print(name);
          
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=name%></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.min.css">
  <link href="${pageContext.request.contextPath}/style/icons/font/css/open-iconic-bootstrap.css" rel="stylesheet">

</head>
<body>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
    <script>
        $(function() {
                 
                $("#sel1").val(document.getElementById("pos").innerHTML);
            });
          
       
        </script>
         <jsp:useBean id= "stl" scope= "page" class= "com.oj.beans.SetToListBean" type= "com.oj.beans.SetToListBean"></jsp:useBean>
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
<p id="pos" hidden><%=pos%></p>
<c:set var="u1" scope="page" value="<%=curuser%>"></c:set>
<c:set var="u2" scope="page" value="<%=title%>"></c:set>
    <div class="container">
        <div class="row">
            <div class="col-sm-8">
                <div class="row">
                    <div class="col"><br/><br/><br/><h3><%=name%></h3></div>
                </div>
                <div class="row">
                    <div class="col">
                                          <br/>      <ul class="nav nav-tabs">
                          <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#details">Details</a>
                          </li>
                          <c:if test="${pageScope.u1 == pageScope.u2}">
                          <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#edit">Edit</a>
                          </li>
                          </c:if>
                          
                        </ul>
                    </div>
                </div>
                

<!-- Tab panes -->


            </div>
            
            <div class="col-sm-4">
                <img class="rounded-circle float-right" width="170" height="170" src="${pageContext.request.contextPath}/Userdata/${pageScope.u1}.png" onerror="this.src='${pageContext.request.contextPath}/Userdata/default.png'"/>
                                            
               </div>
        </div>
        <div class="row">
            <div class="col-sm-8">
                <div class="card bg-light text-dark">
                <div class="card-body">
                       <div class="tab-content">
                    <div id="details" class="container tab-pane active">
                       
                         <table class="table">
    
                                <tbody>
                                  <tr>
                                    <td><b>Username:</b></td>
                                    <td><%=title%></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>About Me:</b></td>
                                    <td><%=aboutme%></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>Country:</b></td>
                                    <td><%=country%></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>State:</b></td>
                                    <td><%=state%></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>City:</b></td>
                                    <td><%=city%></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>Motto:</b></td>
                                    <td><%=motto%></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>Student/Professional:</b></td>
                                    <td><%=pos%></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>Institution:</b></td>
                                    <td><%=inst%></td>
                                    <td></td>
                                  </tr>
                                </tbody>
                              </table>
                    </div>
                                     <div id="edit" class="container tab-pane fade">
                                         <form action="./update" method="post" enctype="multipart/form-data">
                                             <table class="table">
    
                                <tbody>
                                  <tr>
                                    <td><b>Username:</b></td>
                                    <td>
                                        <label name="uname" id="uname"><%=title%></label></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>Name:</b></td>
                                    <td>
                                        <div class="form-group">
            
                                            <input type="text" class="form-control" id="name" name="name" value="<%=name%>" />
                                            </div>
                                        </td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>Email:</b></td>
                                    <td>
                                        <div class="form-group">
            
                                            <input type="email" class="form-control" id="email" name="email" value="<%=email%>" />
                                            </div>
                                        </td>
                                    <td></td>
                                  </tr>
                                 <tr>
                                    <td><b>Profile:</b></td>
                                    <td>
                                       <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="uimg" name="uimg">
                                        <label class="custom-file-label">Choose file...</label>
                                       
                                      </div>
                                        </td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>About Me:</b></td>
                                    <td>
                                        <div class="form-group">
                                            <textarea class="form-control" rows="2" id="aboutme" name="aboutme" ><%=aboutme%></textarea>
                                        </div>
                                    </td>
                                   <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>Institution:</b></td>
                                    <td>
                                        <div class="form-group">
            
                                            <input type="text" class="form-control" id="inst" name="inst" value="<%=inst%>" />
                                            </div>
                                        </td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>Website:</b></td>
                                    <td>
                                        <div class="form-group">
            
                                            <input type="text" class="form-control" id="link" name="link" value="<%=link%>" />
                                            </div>
                                        </td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>Country:</b></td>
                                    <td><div class="form-group">
            
                                            <input type="text" class="form-control" id="cnty" name="cnty" value="<%=country%>" />
                                            </div></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>State:</b></td>
                                    <td><div class="form-group">
            
                                            <input type="text" class="form-control" id="state" name="state" value="<%=state%>" />
                                            </div></td>
                                   <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>City:</b></td>
                                    <td><div class="form-group">
            
                                            <input type="text" class="form-control" id="city" name="city" value="<%=city%>" />
                                            </div></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>Motto:</b></td>
                                    <td>
                                        <div class="form-group">
            
                                            <input type="text" class="form-control" id="motto" name="motto" value="<%=motto%>" />
                                            </div>
                                        </td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td><b>Student/Professional:</b></td>
                                    <td>
                                        <select class="form-control" name="pos" id="sel1">
                                          
                                                   
                                              <option value="professional">Professional</option>
                                              <option value="student">Student</option>
                                              </select>
                                        
                                        </td>
                                                                        <td></td>

                                  </tr>
                                  <tr>
                                    <td></td>
                                    <td>
                                         <div align="center">
                                         <button  type="submit" class="btn btn-outline-primary">Update</button>
                                       </div>
                                    </td>
                                    <td></td>
                                  </tr>
                                </tbody>
                              </table>
                                        </form>
                                    </div>    
                </div>
                </div>
              </div>
             
            </div>
                                            <div class="col-sm-4">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="row">
                                                            <div class="col"><center><br/><b>Rating</b></center></div>
                                                            <div class="col"><center><b>Global Rank</b></center></div>
                                                            <div class="col"><center><b>Country Rank</b></center></div>
                                                        </div>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col"><center><%=rating%>(NA)</center></div>
                                                            <div class="col"><center><%=grank%>(NA)</center></div>
                                                            <div class="col"><center><%=crank%>(NA)</center></div>
                                                        </div>
                                                    </div> 
                                                    
                                                  </div>
                                                 <br/>
                                                 <% int acs=stl.getVer(uname,"AC");
                                                    int was=stl.getVer(uname, "WA");
                                                    int rtes=stl.getVer(uname, "RTE");
                                                    int tles=stl.getVer(uname, "TLE");
                                                    int ctes=stl.getVer(uname, "CTE");
                                                    int total=acs+was+rtes+tles+ctes;
                                                 %>
                                                       <div class="card">
                                                           <div class="card-header">
                                                               Submission Details
                                                           </div> 
                                                           <div class="card-body">
                                                        <table class="table">
                                                                
                                                                <tbody>
                                                                  <tr>
                                                                      <th scope="row" class="thead-light">Total Submissions</th>
                                                                      <td><%=total%></td>
                                                                    
                                                                  </tr>
                                                                  <tr>
                                                                      <th scope="row" class="thead-light">Compilation Error <span class="oi oi-warning" title="Compile Error" style="color: #ffc107"></span></th>
                                                                    <td><%=ctes%></td>
                                                                    
                                                                  </tr>
                                                                  <tr>
                                                                      <th scope="row" class="thead-light">Submissions Accepted <span class="oi oi-check" title="Correct Answer" style="color: #34ce57"></span></th>
                                                                    <td><%=acs%></td>
                                                                    
                                                                  </tr>
                                                                  <tr>
                                                                      <th scope="row" class="thead-light">Wrong Answer <span class="oi oi-x" title="Wrong Answer" style="color: red"></span></th>
                                                                    <td><%=was%></td>
                                                                    
                                                                  </tr>
                                                                  <tr>
                                                                      <th scope="row" class="thead-light">Run Time Error <span class="oi oi-warning" title="Timeout" style="color: red"></span></th>
                                                                    <td><%=rtes%></td>
                                                                    
                                                                  </tr>
                                                                  <tr>
                                                                      <th scope="row" class="thead-light">Time Limit Exceeded <span class="oi oi-clock" title="Runtime Error" style="color: red"></span></th>
                                                                    <td><%=tles%></td>
                                                                    
                                                                  </tr>
                                                                  
                                                                </tbody>
                                                              </table>
                                                           </div>
                                            </div>
        </div>
    </div>
    </body>
</html>
