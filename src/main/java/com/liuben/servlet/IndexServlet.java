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
@WebServlet(name = "IndexServlet", urlPatterns = {"/IndexServlet"})
public class IndexServlet extends HttpServlet {

    ControladoraLogica controladoraLogica = new ControladoraLogica();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        getSchedule(request);
        getDoctor(request);
        calculateWorkDays(request, new Date());
        initUserEntity();
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("action")) {
            case "sendValues":
                sendValues(request);
                break;
            case "cancelCreateElement":
                cancelCreateElement(request);
                break;
            case "create":
                createSchedule(request);
                break;
            default:
                break;
        }
        getSchedule(request);
        getDoctor(request);
        calculateWorkDays(request, new Date());
        initUserEntity();
        response.sendRedirect("index.jsp");
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

    private void initUserEntity() {
        List<User> users = controladoraLogica.getUsers();
        if (users != null && users.size() == 0) {
            controladoraLogica.createUser(new User(0, "admin", "admin", "admin"));
        }
    }

    public List<Date> calculateWorkDays(HttpServletRequest request, Date startDate) {
        Calendar startCal = Calendar.getInstance().getInstance();
        startCal.setTime(startDate);
        List<Date> workDaysList = new ArrayList<>();
        int workDays = 0;
        do {
            startCal.add(Calendar.DAY_OF_MONTH, 1);
            if (startCal.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY && startCal.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
                workDays++;
                int dayOfYear = startCal.get(Calendar.DAY_OF_YEAR);
                Calendar calendar = Calendar.getInstance();
                calendar.set(Calendar.DAY_OF_YEAR, dayOfYear);
                workDaysList.add(calendar.getTime());
            }
        } while (workDays < 6);
        HttpSession mysession = request.getSession();
        mysession.setAttribute("workDaysList", workDaysList);
        return workDaysList;
    }

    private void sendValues(HttpServletRequest request) {
        String workDay = request.getParameter("workDay");
        String appointmentTime = request.getParameter("appointmentTime");
        String availableDoctors = request.getParameter("availableDoctors");
        long timeInMillis = Long.parseLong(workDay);
        Date selectedDate = new Date(timeInMillis);
        List<Doctor> availableDoctorsList = new ArrayList<>();
        String[] availableDoctorsIds = availableDoctors.split(" ");
        for (int i = 0; i < availableDoctorsIds.length; i++) {
            Doctor doctor = controladoraLogica.getDoctor(Integer.parseInt(availableDoctorsIds[i]));
            if (doctor != null) {
                availableDoctorsList.add(doctor);
            }
        }
        HttpSession mysession = request.getSession();
        mysession.setAttribute("sendValues", "sendValues");
        mysession.setAttribute("selectedDate", selectedDate);
        mysession.setAttribute("selectedAppointmentTime", appointmentTime);
        mysession.setAttribute("availableDoctorsList", availableDoctorsList);
    }

    private void cancelCreateElement(HttpServletRequest request) {
        HttpSession mysession = request.getSession();
        mysession.setAttribute("sendValues", null);
        mysession.setAttribute("selectedDate", null);
        mysession.setAttribute("selectedAppointmentTime", null);
        mysession.setAttribute("availableDoctorsList", null);
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
            long timeInMillis = Long.parseLong(dateScheduled);
            Date date = new Date(timeInMillis);
            String timeSchedules = request.getParameter("timeSchedules");
            controladoraLogica.createSchedule(new Schedule(0, date, timeSchedules, "", patientCreated, doctorSelected));
            cancelCreateElement(request);
        } catch (Exception ex) {
            Logger.getLogger(PatientServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
