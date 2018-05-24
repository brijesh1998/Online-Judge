<%-- 
    Document   : logoutnav
    Created on : 3 Apr, 2018, 11:11:13 PM
    Author     : brizz
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <c:if test="${sessionScope.curruser != null}">
                <li class="nav-item"><a href="${pageContext.request.contextPath}/profile.jsp" class="nav-link">Profile(${sessionScope.curruser})</a></li>
                </c:if>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/submissions.jsp" class="nav-link">Submissions</a></li>
            </ul>
            <ul class="nav navbar-nav ml-auto">
                
                <li class="nav-item">
                    <form class="form" role="form" action="${pageContext.request.contextPath}/logout" method="post">
                    <button type="submit" id="logout" name="logout" class="btn btn-primary btn-block">Logout</button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</nav>
