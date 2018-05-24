<%-- 
    Document   : register
    Created on : 11 Mar, 2018, 4:08:52 PM
    Author     : brizz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
	<title>Check</title>
	<link rel="stylesheet" href="./style/css/bootstrap.min.css">
           <style>
#snackbar {
    visibility: hidden;
    min-width: 250px;
    margin-left: -125px;
    background-color: #333;
    color: #fff;
    text-align: center;
    border-radius: 2px;
    padding: 16px;
    position: fixed;
    z-index: 1;
    right: 5%;
    top: 70px;
    font-size: 17px;
}

#snackbar.show {
    visibility: visible;
    -webkit-animation: fadein 1.0s, fadeout 1.0s 4.0s;
    animation: fadein 1.0s, fadeout 1.0s 4.0s;
}

@-webkit-keyframes fadein {
    from {top: 0; opacity: 0;} 
    to {top: 70px; opacity: 1;}
}

@keyframes fadein {
    from {top: 0; opacity: 0;}
    to {top: 70px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {top: 70px; opacity: 1;} 
    to {top: 0; opacity: 0;}
}

@keyframes fadeout {
    from {top: 70px; opacity: 1;}
    to {top: 0; opacity: 0;}
}
</style>

</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<script src="./style/js/bootstrap.min.js"></script>
        
         <script>
            function myFunction() {
                var x = document.getElementById("snackbar")
                x.className = "show";
                setTimeout(function(){ x.className = x.className.replace("show", ""); }, 5000);
            }

            </script>

            <c:if test="${param.msg == 'auth'}">
            <div id="snackbar">Please Login to submit</div>
                <script>
                    myFunction();
                </script>
            </c:if>
        
        
        <div class="row">
            <div class="col">&nbsp;<br /><br /><br /><br /><br /><br /></div>
        </div>
        <c:if test = "${param.msg == 'already exist'}">
        <div id="msg" class="row">
            <div class="col"></div>
            <div class="col">
                <div class="alert alert-danger alert-dismissible fade show">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>Error</strong> Username already exist.
                </div>
            </div>
            <div class="col"></div>
        </div>
        </c:if>
       <c:if test = "${param.msg == 'Username or Password invalid'}">
        <div id="msg" class="row">
            <div class="col"></div>
            <div class="col">
                <div class="alert alert-danger alert-dismissible fade show">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>Error</strong> Username or Password invalid.
                </div>
            </div>
            <div class="col"></div>
        </div>
        </c:if>
  <!-- Tab panes -->
        
  
    <div class="row">
            <div class="col"></div>
            
            <div class="col">  
                 <ul class="nav nav-tabs" role="tablist">
            <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#home">Create Account</a>
            </li>
            <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#menu1">Login</a>
            </li>
    
        </ul>
<% String fname=(String)request.getSession().getAttribute("name");
    String Email=(String)request.getSession().getAttribute("email");
   
    if(fname==null)fname="";
    if(Email==null)Email="";
    // out.print(fname +" "+Email);
    request.getSession().setAttribute("name", "");
            request.getSession().setAttribute("email", "");
%>
                <div class="tab-content">
                <div id="home" class="container tab-pane active"><br>
                <div class="card bg-light text-dark">
                    <div class="card-body">
                        
                        
                                <form action="${pageContext.request.contextPath}/register" method="post">
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-group">
            
                                                <input type="text" class="form-control" id="uname" placeholder="Username" name="uname" />
                                            </div>
                                            <div class="form-group">

                                                <input type="text" class="form-control" id="name" placeholder="Name" name="name" value="<%=fname%>" />
                                            </div>
                                            <div class="form-group">

                                                <input type="email" class="form-control" id="email" placeholder="Email" name="email" value="<%=Email%>" />
                                            </div>
                                            <div class="row">
                                            <div class="col">
                                                <div class="radio">
                                                        <label><input type="radio" value="student" name="pos"> Student</label>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="radio">
                                                 <label><input type="radio" value="professional" name="pos"> Professional</label>
                                             </div>
                                            </div>
                                           
                                            
                                            </div>
                                            <div class="form-group">

                                                <input type="password" class="form-control" id="pwd" placeholder="Password" name="pwd" />
                                            </div>
                                            <div class="form-group">

                                                <input type="password" class="form-control" id="rpwd" placeholder="Re-enter Password" name="rpwd" />
                                            </div>
                                        </div>
                                        <div class="col"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <div class="radio">
                                                        <label><input type="radio" value="male" name="gen"> Male</label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="radio">
                                                <label><input type="radio" value="female" name="gen"> Female</label>
                                            </div>
                                        </div>
                                         <div class="col"></div>
                                          <div class="col"></div>
                                    </div>
                                    <div class="row">
                                    <div class="col"></div>
                                    <div class="col">
                                       <div align="center">
                                         <button  type="submit" class="btn btn-outline-primary">Register</button>
                                       </div>
                                    </div>
                                    <div class="col"></div>
                                    </div>    
            
            
           
        </form>

                        </div>
                </div>
                 </div> 
                    <div id="menu1" class="container tab-pane fade"><br>
                        <div class="card bg-light text-dark">
                            <div class="card-body">
                        <form action="${pageContext.request.contextPath}/validate" method="post">
                               <div class="row">
                                        <div class="col">
                                            <div class="form-group">
            
                                                <input type="text" class="form-control" id="uname" placeholder="Username" name="uname" />
                                            </div>
                                            <div class="form-group">

                                                <input type="password" class="form-control" id="pwd" placeholder="Password" name="pwd" />
                                            </div>
                                        </div>
                                        <div class="col"></div>
                                    </div>
                             <div class="row">
                                    <div class="col"></div>
                                    <div class="col">
                                       <div align="center">
                                         <button  type="submit" class="btn btn-outline-primary">Login</button>
                                       </div>
                                    </div>
                                    <div class="col"></div>
                                    </div>    
                        </form>
                            </div>
                        </div>
            </div>
                </div>
            </div>
            <div class="col"></div>
       
            
   
        </div>
      
      


</body>
</html>
