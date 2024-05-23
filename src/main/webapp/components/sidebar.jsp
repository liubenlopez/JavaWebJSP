<%-- 
    Document   : sidebar
    Created on : 17 may. 2024, 18:30:15
    Author     : LiubenPC
--%>

<%@page import="com.liuben.logica.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.jsp">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-clipboard-list" style="width: 22px; height: 22px;"></i>
        </div>
        <div class="sidebar-brand-text mx-3">
            <div style="font-weight: 100; letter-spacing: 10px; font-size: 10px; margin-left: 12px;">Medical</div> 
            <div>Appointments</div>
        </div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <% User userlogged2 = (User) request.getSession().getAttribute("userlogged");%>
    <%if (userlogged2 != null) {%>

    <!-- Heading -->
    <div class="sidebar-heading">
        Management
    </div>

    <li class="nav-item">
        <a class="nav-link collapsed pb-0" href="doctors.jsp">
            <i class="fa fa-user-md"></i>
            <span>Doctors</span>
        </a>
    </li>

    <li class="nav-item">
        <a class="nav-link collapsed pb-0" href="patients.jsp">
            <i class="fas fa-hospital-user"></i>
            <span>Patients</span>
        </a>
    </li>
    
    <li class="nav-item">
        <a class="nav-link collapsed pb-0" href="appointments.jsp">
            <i class="fas fa-clipboard-list"></i>
            <span>Appointments</span>
        </a>
    </li>

    <li class="nav-item">
        <a class="nav-link collapsed" href="users.jsp">
            <i class="fas fa-users"></i>
            <span>System Users</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <%}%>

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

</ul>
