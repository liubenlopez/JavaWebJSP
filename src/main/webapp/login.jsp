<%-- 
    Document   : login
    Created on : 20 may. 2024, 11:23:07
    Author     : LiubenPC
--%>

<%-- 
    Document   : index
    Created on : 17 may. 2024, 14:19:00
    Author     : LiubenPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.liuben.logica.User" %>

<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Medical Appointments</title>

        <!-- Custom fonts for this template-->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/toastify/toastify.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="css/sb-admin-2.min.css" rel="stylesheet">
        <link href="css/custom.css" rel="stylesheet">

    </head>

    <body class="bg-gradient-primary">

        <%
            User userlogged1 = (User) request.getSession().getAttribute("userlogged");
            if (userlogged1 != null) {
                response.sendRedirect("index.jsp");
            }
        %>

        <div class="container margin-top-auto">

            <!-- Outer Row -->
            <div class="row justify-content-center">

                <div class="col-xl-10 col-lg-12 col-md-9">

                    <div class="card o-hidden border-0 shadow-lg my-5">
                        <div class="card-body p-0">
                            <!-- Nested Row within Card Body -->
                            <div class="row">
                                <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                                <div class="col-lg-6">
                                    <div class="p-5">
                                        <div class="text-center">
                                            <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                                        </div>
                                        <form class="user" id="loginForm" action="LoginServlet" method="post">
                                            <div class="form-group">
                                                <input type="text" class="form-control form-control-user"
                                                       placeholder="Username" id="username" name="username" required="">
                                            </div>
                                            <div class="form-group">
                                                <input type="password" class="form-control form-control-user"
                                                       placeholder="Password" id="password" name="password" required="">
                                            </div>
                                            <div class="form-group">
                                                <div class="custom-control custom-checkbox small">
                                                    <input type="checkbox" class="custom-control-input" id="customCheck">
                                                    <label class="custom-control-label" for="customCheck">Remember
                                                        Me</label>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-primary btn-user btn-block">
                                                Login
                                            </button>

                                            <hr>

                                            <button type="button" onclick="loginDefaulUser()" class="btn btn-success btn-user btn-block">
                                                <i class="fa fa-key fa-fw"></i> Login with defaul user
                                            </button>
                                            <a class="btn btn-info btn-user btn-block" href="index.jsp">
                                                <i class="fa fa-home fa-fw"></i> Go Home!
                                            </a>

                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </div>

        <!-- Bootstrap core JavaScript-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <script src="vendor/toastify/toastify-js.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="js/sb-admin-2.min.js"></script>

        <script>
            function loginDefaulUser() {
                document.getElementById('username').value = 'admin';
                document.getElementById('password').value = 'admin';
                document.getElementById('loginForm').submit();
            }
        </script>

        <script>
            var toastify = Toastify({
                text: "Incorrect username or password",
                duration: 5000,
                close: true,
                style: {
                    background: "#e74a3b",
                }
            });
            <% String loginError = (String) request.getSession().getAttribute("loginError");%>
            <%if (loginError != null && !loginError.equals("")) {%>
            toastify.showToast();
            <%}%>
        </script>
    </body>

</html>