<%-- 
    Document   : index
    Created on : 17 may. 2024, 14:19:00
    Author     : LiubenPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
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
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="css/sb-admin-2.min.css" rel="stylesheet">
        <link href="css/custom.css" rel="stylesheet">

    </head>

    <body id="page-top">

        <%
            User userlogged1 = (User) request.getSession().getAttribute("userlogged");
            if (userlogged1 == null) {
                response.sendRedirect("login.jsp");
            }
        %>

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <%@include file="components/sidebar.jsp" %>
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <%@include file="components/header.jsp" %>
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid">

                        <h1>System Users</h1>

                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-primary mt-2 mb-4" id="buttonModal" data-toggle="modal" data-target="#elementForm">
                            Create User
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="elementForm" tabindex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <form class="user" action="UserServlet" method="post">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="formName">Create User</h5>
                                            <button type="button" class="close" onclick="cancelEditElement();" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="username">Insert Username</label>
                                                <input type="text" class="form-control" id="username" name="username"
                                                       placeholder="Username" required="" minlength="5">
                                            </div>
                                            <div class="form-group">
                                                <label for="password">Insert Password</label>
                                                <input type="password" class="form-control" id="password" name="password" 
                                                       placeholder="Password" required="" minlength="5">
                                            </div>

                                            <input type="hidden" id="id" name="id" value="0"/>
                                            <input type="hidden" id="actionForm" name="action" value="create"/>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" onclick="cancelEditElement();" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary"><i class="fas fa-check"></i> <span id="buttonText">Create</span></button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- Modal End -->

                        <% List<User> users = (List<User>) request.getSession().getAttribute("users");%>
                        <%if (users != null && users.size() > 0) { %>
                        <div class="row">
                            <% for (User u : users) {%>
                            <div class="col-xl-3 col-md-6 mb-4">
                                <div class="card border-left-primary shadow h-100 py-2">
                                    <div class="card-body">
                                        <form id="deleteForm<%= u.getId()%>" action="UserServlet" method="post">
                                            <input type="hidden" name="id" value="<%= u.getId()%>"/>
                                            <input type="hidden" name="action" value="delete"/>
                                        </form>
                                        <div style="border-bottom: 1px solid #dddfeb; width: 100%; height: 1px; margin-top: 10px; margin-bottom: 1.25rem;">
                                            <i onclick="editElement('<%= u.getId()%>', '<%=u.getUsername()%>');" data-toggle="modal" data-target="#elementForm" class="fa fa-pencil-alt edit-element"></i>
                                            <i onclick="confirm('Are you sure you want to delete this user?') ? deleteElement(<%= u.getId()%>) : '';" class="fa fa-times delete-element"></i>
                                        </div>
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="h5 mb-0 font-weight-bold text-gray-800"><%=u.getUsername()%></div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-user fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%}%>
                        </div>
                        <%} else {%>
                        <div class="row">
                            <div class="col-xl-12 col-md-12">
                                <div class="card border-left-warning shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">There are no registered users</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-info-circle fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>

                        <!-- ***** section to request data START ***** -->
                        <%if (users == null) { %>
                        <form id="requestedDataForm" action="UserServlet" method="get"></form>
                        <%}%>
                        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                let requestedDataForm = document.getElementById('requestedDataForm');
                                if (requestedDataForm) {
                                    requestedDataForm.submit();
                                }
                            });
                        </script>
                        <!-- ***** section to request data END ***** -->

                        <!-- ***** section to edit elements START ***** -->
                        <script>
                            function editElement(id, username) {
                                document.getElementById('buttonModal').textContent = 'Edit User';
                                document.getElementById('formName').textContent = 'Edit User';
                                document.getElementById('buttonText').textContent = 'Edit';
                                document.getElementById('id').value = id;
                                document.getElementById('username').value = username;
                                document.getElementById('actionForm').value = 'edit';
                            }

                            function cancelEditElement() {
                                document.getElementById('buttonModal').textContent = 'Create User';
                                document.getElementById('formName').textContent = 'Create User';
                                document.getElementById('buttonText').textContent = 'Create';
                                document.getElementById('id').value = 0;
                                document.getElementById('username').value = '';
                                document.getElementById('password').value = '';
                                document.getElementById('actionForm').value = 'create';
                            }
                        </script>
                        <!-- ***** section to edit elements END ***** -->

                        <!-- ***** section to delete elements START ***** -->
                        <script>
                            function deleteElement(id) {
                                let deleteForm = document.getElementById('deleteForm' + id);
                                if (deleteForm) {
                                    deleteForm.submit();
                                }
                            }
                        </script>
                        <!-- ***** section to delete elements END ***** -->

                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- End of Main Content -->

                <!-- Footer -->
                <%@include file="components/footer.jsp" %>
                <!-- End of Footer -->

            </div>
            <!-- End of Content Wrapper -->

        </div>
        <!-- End of Page Wrapper -->

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>

        <!-- Bootstrap core JavaScript-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="js/sb-admin-2.min.js"></script>

    </body>

</html>