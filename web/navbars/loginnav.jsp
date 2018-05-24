<%-- 
    Document   : loginnav.jsp
    Created on : 3 Apr, 2018, 11:09:35 PM
    Author     : brizz
--%>

<%
    String uri = request.getRequestURI();
                String pageName = uri.substring(uri.lastIndexOf("/")+1);
                String id=request.getParameter("id");
                if(id == null)
                id="yes";
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark " role="navigation">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home.jsp">Home</a>
        <button class="navbar-toggler border-0" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar">
            &#9776;
        </button>
        <div class="collapse navbar-collapse" id="exCollapsingNavbar">
            <ul class="nav navbar-nav">
                <li class="nav-item"><a href="${pageContext.request.contextPath}/problems.jsp" class="nav-link">Practice</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/discuss.jsp" class="nav-link">Discuss</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/submissions.jsp" class="nav-link">Submissions</a></li>
                <li class="nav-item"><a href="#" class="nav-link">-</a></li>
            </ul>
            <ul class="nav navbar-nav flex-row justify-content-between ml-auto">
                
                <li class="dropdown order-1">
                    <button type="button" id="dropdownMenu1" data-toggle="dropdown" class="btn btn-outline-secondary dropdown-toggle ">Login <span class="caret"></span></button>
                    <ul class="dropdown-menu dropdown-menu-right mt-1">
                      <li class="p-3" >
                         
                          <form action="${pageContext.request.contextPath}/validate?from=<%=pageName%>&id=<%=id%>" method="post">
                                <div class="form-group">
                                    <input id="uname" name="uname" placeholder="Username" class="form-control form-control-sm" type="text" required/>
                                </div>
                                <div class="form-group">
                                    <input id="pwd" name="pwd" placeholder="Password" class="form-control form-control-sm" type="password" required/>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary btn-block">Login</button>
                                </div>
                                <div class="form-group text-xs-center">
                                    <small><a href="${pageContext.request.contextPath}/forgot.jsp">Forgot password?</a></small>
                                </div>
                            </form>
                        </li>
                    </ul>
                </li> 
               
                <li class="dropdown order-1">
                &nbsp; &nbsp; &nbsp;
                <a href="${pageContext.request.contextPath}/register.jsp"><button type="button" id="signup" class="btn btn-primary">Sign Up</button></a>
                   
                </li>
            </ul>
        </div>
    </div>
</nav>
