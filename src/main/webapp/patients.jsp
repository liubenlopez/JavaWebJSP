<%-- 
    Document   : index
    Created on : 17 may. 2024, 14:19:00
    Author     : LiubenPC
--%>

<%@page import="java.util.Date"%>
<%@page import="com.liuben.logica.Patient"%>
<%@page import="java.util.List"%>
<%@page import="com.liuben.logica.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

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

                        <h1>Patients</h1>

                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-primary mt-2 mb-4" id="buttonModal" data-toggle="modal" data-target="#elementForm">
                            Create Patient
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="elementForm" tabindex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <form class="user" action="PatientServlet" method="post">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="formName">Create Patient</h5>
                                            <button type="button" class="close" onclick="cancelEditElement();" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="name">First Name</label>
                                                <input type="text" class="form-control" id="name" name="name"
                                                       placeholder="First name" required="" minlength="3">
                                            </div>
                                            <div class="form-group">
                                                <label for="lastName">Last Name</label>
                                                <input type="text" class="form-control" id="lastName" name="lastName"
                                                       placeholder="Last name" required="" minlength="3">
                                            </div>
                                            <div class="form-group">
                                                <label for="phone">Phone</label>
                                                <input type="tel" class="form-control" id="phone" name="phone"
                                                       pattern="[0-9]{3}(-|\s)?[0-9]{3}(-|\s)?[0-9]{4}" placeholder="000-000-0000" required="">
                                            </div>
                                            <div class="form-group">
                                                <label for="email">Email</label>
                                                <input type="email" class="form-control" id="email" name="email" 
                                                       placeholder="Email" required="">
                                            </div>
                                            <div class="form-group">
                                                <label for="bloodType">Blood Type</label>
                                                <select class="form-control" id="bloodType" name="bloodType">
                                                    <option value="A positive (A+)">A positive (A+)</option>
                                                    <option value="A negative (A-)">A negative (A-)</option>
                                                    <option value="B positive (B+)">B positive (B+)</option>
                                                    <option value="B negative (B-)">B negative (B-)</option>
                                                    <option value="AB positive (AB+)">AB positive (AB+)</option>
                                                    <option value="AB negative (AB-)">AB negative (AB-)</option>
                                                    <option value="O positive (O+)">O positive (O+)</option>
                                                    <option value="O negative (O-)">O negative (O-)</option>                                                    
                                                </select>
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

                        <% List<Patient> patients = (List<Patient>) request.getSession().getAttribute("patients");%>
                        <%if (patients != null && patients.size() > 0) { %>
                        <div class="card shadow mb-4">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>Firat Name</th>
                                                <th>Last Name</th>
                                                <th>Phone</th>
                                                <th>Email</th>
                                                <th>Blood Type</th>
                                                <th></th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (Patient p : patients) {%>
                                            <tr>
                                                <td><%= p.getName()%></td>
                                                <td><%= p.getLastName()%></td>
                                                <td><%= p.getPhone()%></td>
                                                <td><%= p.getEmail()%></td>
                                                <td><%= p.getBloodType()%></td>
                                                <td class="text-center">
                                                    <i onclick="editElement('<%= p.getId()%>', '<%=p.getName()%>', '<%=p.getLastName()%>', '<%=p.getPhone()%>', '<%=p.getEmail()%>', '<%=p.getBloodType()%>');" data-toggle="modal" data-target="#elementForm" class="fa fa-pencil-alt text-primary cursor-pointer"></i>
                                                </td>
                                                <td class="text-center">
                                                    <form id="deleteForm<%= p.getId()%>" action="PatientServlet" method="post">
                                                        <input type="hidden" name="id" value="<%= p.getId()%>"/>
                                                        <input type="hidden" name="action" value="delete"/>
                                                    </form>
                                                    <i onclick="confirm('Are you sure you want to delete this patient?') ? deleteElement(<%= p.getId()%>) : '';" class="fa fa-times text-danger cursor-pointer"></i>
                                                </td>
                                            </tr>
                                            <%}%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <%} else {%>
                        <div class="row">
                            <div class="col-xl-12 col-md-12">
                                <div class="card border-left-warning shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">There are no registered patients</div>
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
                        <%if (patients == null) { %>
                        <form id="requestedDataForm" action="PatientServlet" method="get"></form>
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
                            function editElement(id, name, lastName, phone, email, bloodType) {
                                document.getElementById('buttonModal').textContent = 'Edit Patient';
                                document.getElementById('formName').textContent = 'Edit Patient';
                                document.getElementById('buttonText').textContent = 'Edit';
                                document.getElementById('id').value = id;
                                document.getElementById('actionForm').value = 'edit';
                                //form fields
                                document.getElementById('name').value = name;
                                document.getElementById('lastName').value = lastName;
                                document.getElementById('phone').value = phone;
                                document.getElementById('email').value = email;
                                document.getElementById('bloodType').value = bloodType;
                            }

                            function cancelEditElement() {
                                document.getElementById('buttonModal').textContent = 'Create Patient';
                                document.getElementById('formName').textContent = 'Create Patient';
                                document.getElementById('buttonText').textContent = 'Create';
                                document.getElementById('id').value = 0;
                                document.getElementById('actionForm').value = 'create';
                                //form fields
                                document.getElementById('name').value = '';
                                document.getElementById('lastName').value = '';
                                document.getElementById('phone').value = '';
                                document.getElementById('email').value = '';
                                document.getElementById('bloodType').value = 'A positive (A+)';
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

        <script src="vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

        <script>
                            // Call the dataTables jQuery plugin
                            $(document).ready(function () {
                                $('#dataTable').DataTable();
                            });
        </script>

    </body>

</html>