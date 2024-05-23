package com.liuben.servlet;

import com.liuben.logica.ControladoraLogica;
import com.liuben.logica.Patient;
import java.io.IOException;
import java.time.Instant;
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
@WebServlet(name = "PatientServlet", urlPatterns = {"/PatientServlet"})
public class PatientServlet extends HttpServlet {

    ControladoraLogica controladoraLogica = new ControladoraLogica();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        getPatients(request);
        response.sendRedirect("patients.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("action")) {
            case "create":
                createPatient(request);
                break;
            case "edit":
                editPatient(request);
                break;
            case "delete":
                deletePatient(request);
                break;
            default:
                break;
        }
        getPatients(request);
        response.sendRedirect("patients.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private List<Patient> getPatients(HttpServletRequest request) {
        List<Patient> patients = controladoraLogica.getPatients();
        HttpSession mysession = request.getSession();
        mysession.setAttribute("patients", patients);
        return patients;
    }

    private void createPatient(HttpServletRequest request) {
        try {
            String name = request.getParameter("name");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String bloodType = request.getParameter("bloodType");
            controladoraLogica.createPatient(new Patient(bloodType, null, 0, "", name, lastName, null, phone, email));
        } catch (Exception ex) {
            Logger.getLogger(PatientServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void editPatient(HttpServletRequest request) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String bloodType = request.getParameter("bloodType");
            Patient patient = controladoraLogica.getPatient(id);
            patient.setName(name);
            patient.setLastName(lastName);
            patient.setPhone(phone);
            patient.setEmail(email);
            patient.setBloodType(bloodType);
            controladoraLogica.editPatient(patient);
        } catch (Exception ex) {
            Logger.getLogger(PatientServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void deletePatient(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        controladoraLogica.deletePatient(id);
    }

}
