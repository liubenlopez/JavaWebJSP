package com.liuben.servlet;

import com.liuben.logica.ControladoraLogica;
import com.liuben.logica.Doctor;
import com.liuben.logica.Patient;
import com.liuben.logica.Schedule;
import com.liuben.logica.User;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author LiubenPC
 */
@WebServlet(name = "ScheduleServlet", urlPatterns = {"/ScheduleServlet"})
public class ScheduleServlet extends HttpServlet {
    
    ControladoraLogica controladoraLogica = new ControladoraLogica();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        getSchedule(request);
        getDoctor(request);
        response.sendRedirect("appointments.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("action")) {
            case "create":
                createSchedule(request);
                break;
            case "edit":
                editSchedule(request);
                break;
            case "delete":
                deleteSchedule(request);
                break;
            default:
                break;
        }
        getSchedule(request);
        getDoctor(request);
        response.sendRedirect("appointments.jsp");
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private List<Schedule> getSchedule(HttpServletRequest request) {
        List<Schedule> schedules = controladoraLogica.getSchedules();
        HttpSession mysession = request.getSession();
        mysession.setAttribute("schedules", schedules);
        return schedules;
    }
    
    private List<Doctor> getDoctor(HttpServletRequest request) {
        List<Doctor> doctors = controladoraLogica.getDoctors();
        HttpSession mysession = request.getSession();
        mysession.setAttribute("doctors", doctors);
        return doctors;
    }
    
    private void createSchedule(HttpServletRequest request) {
        try {
            String name = request.getParameter("name");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String bloodType = request.getParameter("bloodType");
            controladoraLogica.createPatient(new Patient(bloodType, null, 0, "", name, lastName, null, phone, email));
            List<Patient> patients = controladoraLogica.getPatients();
            Patient patientCreated = null;
            for (Patient patient : patients) {
                if (patient.getBloodType().equals(bloodType) && patient.getName().equals(name) && patient.getLastName().equals(lastName) && patient.getPhone().equals(phone) && patient.getEmail().equals(email)) {
                    patientCreated = patient;
                    break;
                }
            }
            String doctor = request.getParameter("doctor");
            Doctor doctorSelected = controladoraLogica.getDoctor(Integer.parseInt(doctor));
            String dateScheduled = request.getParameter("dateScheduled");
            long oneDayInMillis = 86400000;
            long timeInMillis = Long.parseLong(dateScheduled) + oneDayInMillis;
            Date date = new Date(timeInMillis);
            String timeSchedules = request.getParameter("timeSchedules");
            controladoraLogica.createSchedule(new Schedule(0, date, timeSchedules, "", patientCreated, doctorSelected));
        } catch (Exception ex) {
            Logger.getLogger(PatientServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void editSchedule(HttpServletRequest request) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Schedule schedule = controladoraLogica.getSchedule(id);
            Patient patient = schedule.getPatient();
            String name = request.getParameter("name");
            patient.setName(name);
            String lastName = request.getParameter("lastName");
            patient.setLastName(lastName);
            String phone = request.getParameter("phone");
            patient.setPhone(phone);
            String email = request.getParameter("email");
            patient.setEmail(email);
            String bloodType = request.getParameter("bloodType");            
            patient.setBloodType(bloodType);
            controladoraLogica.editPatient(patient);
            String doctor = request.getParameter("doctor");
            Doctor doctorSelected = controladoraLogica.getDoctor(Integer.parseInt(doctor));
            schedule.setDoctor(doctorSelected);
            String dateScheduled = request.getParameter("dateScheduled");
            long oneDayInMillis = 86400000;
            long timeInMillis = Long.parseLong(dateScheduled) + oneDayInMillis;
            Date date = new Date(timeInMillis);
            schedule.setDateScheduled(date);
            String timeSchedules = request.getParameter("timeSchedules");
            schedule.setTimeSchedules(timeSchedules);
            controladoraLogica.editSchedule(schedule);
        } catch (Exception ex) {
            Logger.getLogger(PatientServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void deleteSchedule(HttpServletRequest request) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            controladoraLogica.deleteSchedule(id);
        } catch (Exception ex) {
            Logger.getLogger(PatientServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
