<%-- 
    Document   : header
    Created on : 17 may. 2024, 18:27:35
    Author     : LiubenPC
--%>

<%@page import="com.liuben.logica.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

    <!-- Sidebar Toggle (Topbar) -->
    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
        <i class="fa fa-bars"></i>
    </button>

    <!-- Topbar Navbar -->
    <ul class="navbar-nav ml-auto">

        <div class="topbar-divider d-none d-sm-block"></div>
        
        <div class="container-fluid">
            <div class="d-flex navbar-text developer-networks">
                <a href="https://www.linkedin.com/in/liuben-lopez-aparicio" target="_blank" class="me-2">
                    <i class="fab fa-linkedin"></i>
                </a>
                <a href="https://github.com/liubenlopez/JavaWebJSP" target="_blank">
                    <i class="fab fa-github"></i>
                </a>
            </div>
            <a href="https://liubenlopez.github.io" target="_blank" class="a-image-profile">
                <img src="img/liuben-lopez-aparicio.jpg" class="image-profile">
            </a>
        </div>        


        <div class="topbar-divider d-none d-sm-block"></div>

        <% User userlogged = (User) request.getSession().getAttribute("userlogged");%>
        <%if (userlogged != null) {%>
        <!-- Nav Item - User Information -->
        <li class="nav-item dropdown no-arrow">
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=userlogged.getUsername()%></span>

            </a>
            <!-- Dropdown - User Information -->
            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                 aria-labelledby="userDropdown">
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                    Logout
                </a>
            </div>
        </li>
        <%} else {%>
        <li class="nav-item dropdown no-arrow">
            <a class="nav-link dropdown-toggle" href="login.jsp" role="button">
                <i class="fa fa-sign-in-alt fa-fw mr-2"></i>
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Login</span>
            </a>
        </li>
        <%}%>

    </ul>

</nav>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                <form id="logoutForm" action="LoginServlet" method="get">
                    <button type="submit" class="btn btn-primary">Logout</button>
                </form>
            </div>
        </div>
    </div>
</div>