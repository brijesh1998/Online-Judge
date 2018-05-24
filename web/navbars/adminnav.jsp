
<nav class="navbar navbar-expand-lg navbar-dark bg-dark " role="navigation">
    <div class="container">
        
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home.jsp">Home</a>
        <button class="navbar-toggler border-0" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar">
            &#9776;
        </button>
        <div class="collapse navbar-collapse" id="exCollapsingNavbar">
            <ul class="nav navbar-nav">
                <li class="nav-item"><a href="${pageContext.request.contextPath}/problems.jsp" class="nav-link">Problems</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/addproblem.jsp" class="nav-link">Add Problem</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/discuss.jsp" class="nav-link">Discuss</a></li>
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
