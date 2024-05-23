<%-- 
    Document   : index
    Created on : 17 may. 2024, 14:19:00
    Author     : LiubenPC
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.liuben.logica.Doctor"%>
<%@page import="com.liuben.logica.Schedule"%>
<%@page import="java.util.List"%>
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

    </head>

    <body id="page-top">

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

                        <nav aria-label="breadcrumb" class="mb-4">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item active" aria-current="page"><i class="fas fa-info-circle"></i> Appointments for the next 6 business days</li>
                            </ol>
                        </nav>

                        <% List<Schedule> schedules = (List<Schedule>) request.getSession().getAttribute("schedules");%>
                        <% List<Doctor> doctors = (List<Doctor>) request.getSession().getAttribute("doctors");%>
                        <% List<Date> workDaysList = (List<Date>) request.getSession().getAttribute("workDaysList");%>
                        <%if (workDaysList != null && workDaysList.size() > 0) { %>
                        <%SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");%>

                        <% String sendValues = (String) request.getSession().getAttribute("sendValues");%>
                        <% Date selectedDate = (Date) request.getSession().getAttribute("selectedDate");%>
                        <% String selectedAppointmentTime = (String) request.getSession().getAttribute("selectedAppointmentTime");%>
                        <% List<Doctor> availableDoctorsList = (List<Doctor>) request.getSession().getAttribute("availableDoctorsList");%>
                        <%if (sendValues != null) {%>
                        <input type="hidden" id="buttonModal" data-toggle="modal" data-target="#elementForm">
                        <script>
                            setTimeout(function () {
                                let buttonModal = document.getElementById("buttonModal");
                                const evento = new MouseEvent('click', {
                                    view: window,
                                    bubbles: true,
                                    cancelable: true
                                });
                                buttonModal.dispatchEvent(evento);
                            }, 100);
                        </script>
                        <!-- Modal -->
                        <div class="modal fade" id="elementForm" tabindex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <form class="user" action="IndexServlet" method="post">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="formName">Create Appointment</h5>
                                            <button type="button" onclick="cancelCreateElement();" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group bg-primary text-white p-2" style="border-radius: .35rem;">
                                                <%
                                                    int selectedAppointmentTimeInt = 0;
                                                    String selectedAppointmentTimeStr = "";
                                                    if (selectedAppointmentTime != null) {
                                                        selectedAppointmentTimeInt = Integer.parseInt(selectedAppointmentTime);
                                                        String selectedAppointmentTimeMeridiam = selectedAppointmentTimeInt < 12 ? "AM" : "PM";
                                                        selectedAppointmentTimeInt = selectedAppointmentTimeInt > 12 ? (selectedAppointmentTimeInt - 12) : selectedAppointmentTimeInt;
                                                        selectedAppointmentTimeStr = String.valueOf(selectedAppointmentTimeInt < 10 ? "0" + selectedAppointmentTimeInt : selectedAppointmentTimeInt) + ":00 " + selectedAppointmentTimeMeridiam;;
                                                    }
                                                %>
                                                <label class="mb-0"><%= dateFormat.format(selectedDate)%> at <%=selectedAppointmentTimeStr%> </label>
                                            </div>
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
                                            <div class="form-group">
                                                <label for="bloodType">Doctor</label>
                                                <select class="form-control" id="doctor" name="doctor">
                                                    <%for (int i = 0; i < availableDoctorsList.size(); i++) {%>
                                                    <option value="<%=availableDoctorsList.get(i).getId()%>"><%=availableDoctorsList.get(i).getName()%></option>
                                                    <%}%>
                                                </select>
                                            </div>

                                            <input type="hidden" id="dateScheduled" name="dateScheduled" value="<%=selectedDate.getTime()%>"/>
                                            <input type="hidden" id="timeSchedules" name="timeSchedules" value="<%=selectedAppointmentTime%>"/>
                                            <input type="hidden" id="id" name="id" value="0"/>
                                            <input type="hidden" id="actionForm" name="action" value="create"/>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" onclick="cancelCreateElement();" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary"><i class="fas fa-check"></i> <span id="buttonText">Create</span></button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- Modal End -->
                        <%}%>



                        <div class="row">


                            <% for (Date workDay : workDaysList) {%>

                            <!-- Content Column -->
                            <div class="col-lg-4">

                                <!-- Project Card Example -->
                                <div class="card shadow mb-4">
                                    <div class="card-header">
                                        <h6 class="m-0 font-weight-bold text-primary"><%= dateFormat.format(workDay)%></h6>
                                    </div>
                                    <div class="card-body">

                                        <% for (int appointmentTime = 8; appointmentTime < 17; appointmentTime++) {%>
                                        <%
                                            if (appointmentTime == 12) {
                                                appointmentTime++;
                                            }
                                        %>
                                        <div>
                                            <h4 class="small font-weight-bold">
                                                <%
                                                    List<Doctor> availableDoctors = new ArrayList<>(doctors);
                                                    String startMeridiam = String.valueOf(appointmentTime < 12 ? "AM" : "PM");
                                                    String endMeridiam = String.valueOf(appointmentTime + 1 < 12 ? "AM" : "PM");
                                                    int startValue = appointmentTime > 12 ? (appointmentTime - 12) : appointmentTime;
                                                    int endValue = appointmentTime + 1 > 12 ? (appointmentTime + 1 - 12) : appointmentTime + 1;
                                                    String start = String.valueOf(startValue < 10 ? "0" + startValue : startValue) + ":00 " + startMeridiam;
                                                    String end = String.valueOf(endValue < 10 ? "0" + endValue : endValue) + ":00 " + endMeridiam;
                                                %>
                                                <%=start%> - <%=end%>
                                                <span class="float-right" id="<%= workDay.getTime()%><%=appointmentTime%>">
                                                    <i onclick="sendValues(<%= workDay.getTime()%><%=appointmentTime%>)" class="fa fa-plus cursor-pointer"></i>
                                                </span>
                                            </h4>
                                            <%if (schedules != null && schedules.size() > 0) { %>
                                            <% for (Schedule s : schedules) {%>
                                            <%if ((dateFormat.format(workDay)).equals(dateFormat.format(s.getDateScheduled())) && s.getTimeSchedules().equals(String.valueOf(appointmentTime))) {%>
                                            <%
                                                for (int i = availableDoctors.size() - 1; i >= 0; i--) {
                                                    if (s.getDoctor().getId() == availableDoctors.get(i).getId()) {
                                                        availableDoctors.remove(i);
                                                    }%>
                                            <%}%>
                                            <span class="badge badge-primary">Dr.<%= s.getDoctor().getName()%> - <%= s.getPatient().getName()%></span>
                                            <%}%>
                                            <%}%>
                                            <%}%>
                                            <%if (availableDoctors.size() == 0) {%>
                                            <script>
                                                let buttonAdd<%= workDay.getTime()%><%=appointmentTime%> = document.getElementById("<%= workDay.getTime()%><%=appointmentTime%>");
                                                if (buttonAdd<%= workDay.getTime()%><%=appointmentTime%>) {
                                                    buttonAdd<%= workDay.getTime()%><%=appointmentTime%>.style.display = "none";
                                                }
                                            </script>
                                            <%} else {%>
                                            <form id="form<%= workDay.getTime()%><%=appointmentTime%>" action="IndexServlet" method="post">
                                                <input type="hidden" name="workDay" value="<%= workDay.getTime()%>">
                                                <input type="hidden" name="appointmentTime" value="<%= appointmentTime%>">
                                                <%
                                                    String availableDoctorsString = "";
                                                    for (int i = availableDoctors.size() - 1; i >= 0; i--) {
                                                        availableDoctorsString += availableDoctors.get(i).getId() + " ";
                                                    }
                                                %>
                                                <input type="hidden" name="availableDoctors" value="<%= availableDoctorsString%>">
                                                <input type="hidden" name="action" value="sendValues">
                                            </form>
                                            <%}%>
                                            <%if (appointmentTime < 16) {%>
                                            <hr style='<%=(appointmentTime==11?"border-top: 1px solid rgb(0 0 0 / 23%);":"")%>'>
                                            <%}%>
                                        </div>
                                        <%}%>

                                    </div>
                                </div>

                            </div>

                            <%}%>
                            <%}%>

                        </div>

                        <form id="formCancelCreateElement" action="IndexServlet" method="post">
                            <input type="hidden" name="action" value="cancelCreateElement">
                        </form>

                        <!-- ***** section to asign values START ***** -->
                        <script>
                            function sendValues(id) {
                                let formSendValues = document.getElementById('form' + id);
                                if (formSendValues) {
                                    formSendValues.submit();
                                }
                            }
                            function cancelCreateElement() {
                                let formCancelCreateElement = document.getElementById('formCancelCreateElement');
                                if (formCancelCreateElement) {
                                    formCancelCreateElement.submit();
                                }
                            }
                        </script>
                        <!-- ***** section to asign values END ***** -->

                        <!-- ***** section to request data START ***** -->
                        <%if (schedules == null) { %>
                        <form id="requestedDataForm" action="IndexServlet" method="get"></form>
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