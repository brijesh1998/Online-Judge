<%-- 
    Document   : forgot
    Created on : 3 May, 2018, 7:09:27 PM
    Author     : brizz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>  
    <html>  
    <head>  
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.min.css">
 <link href="${pageContext.request.contextPath}/style/icons/font/css/open-iconic-bootstrap.css" rel="stylesheet">
    <title>Forgot Password</title>  
      
    </head>  
    <body>  
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <%
        String ch=(String)request.getParameter("ch");
        if(ch==null)
        ch="asd";
        String user=(String)request.getParameter("uid");
        if(user == null)
            user="12";
        String chapp=(String)request.getServletContext().getAttribute(user);
        if(chapp == null)
        chapp="qwe";
        
      //  response.getWriter().println(request.getRequestURI() + " "+ request.getRequestURL());
    %>
    <script>
        window.onload = function() {
            onLoad();
        }
        function sendMail()
        {
            var uid = document.getElementById("uid").value; 
            document.getElementById("done").innerHTML = "brizzzzzz" + uid;
            document.getElementById("change").disabled = true;
            document.getElementById("alert").style.visibility='visible';
              var xhttp = new XMLHttpRequest();
              xhttp.onreadystatechange=function() {
                if (this.readyState == 4 && this.status == 200) {
                  document.getElementById("alert").innerHTML="Mail sent to change password..";
                }
              };
              xhttp.open("GET", "./changepwd?user="+uid, true);
              xhttp.send();   
           
        }
        function onLoad()
        {
            
            //document.getElementById("done").innerHTML = "llo";
            var s1="<%=ch%>";
            var s2="<%=chapp%>";
            if(s1 != s2)
            {
                document.getElementById("panel1").style.visibility='visible';
                document.getElementById("panel2").style.visibility='hidden';
            }
            else
            {
                document.getElementById("panel2").style.visibility='visible';
                document.getElementById("panel1").style.visibility='hidden';
            }
        }
       
    </script>
    <div class="container">
        <br/><br/>
        <p id="done"></p>
        <div id="panel1">
            <div class="row">
                <div class="col">
                    <div id="alert" class="alert alert-primary" role="alert" style="visibility: hidden">
                        Mail Sending........
                      </div>
                </div>
            </div>
            <div class="row">
                <div class="col-3"><input id="uid" name="uid" placeholder="Username" class="form-control" type="text" required/></div>
                <div class="col-3"><button id="change" class="btn btn-primary btn-block" onclick="sendMail()">Change Password</button></div>
            </div>
        </div>
        <div id="panel2">
            <form action="${pageContext.request.contextPath}/changepwd" method="post">
            <div class="row">
                <div class="col-5">
                    <input type="hidden" name="userid" value="<%=user%>"/>
                    <div class="row">
                        <div class="col">
                            <input id="pwd1" name="pwd1" placeholder="New Password" class="form-control" type="password" required/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <input id="pwd2" name="pwd2" placeholder="Re-enter Password" class="form-control" type="password" required/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <button id="chpwd" type="submit" class="btn btn-primary btn-block">Change Password</button>
                        </div>
                    </div>
                </div>
            </div>
            </form>
        </div>
    </div>
    </body>  
    </html>  