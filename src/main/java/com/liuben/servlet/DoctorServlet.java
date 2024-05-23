package com.liuben.servlet;

import com.liuben.logica.ControladoraLogica;
import com.liuben.logica.Doctor;
import java.io.IOException;
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
@WebServlet(name = "DoctorServlet", urlPatterns = {"/DoctorServlet"})
public class DoctorServlet extends HttpServlet {

    ControladoraLogica controladoraLogica = new ControladoraLogica();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        getDoctor(request);
        response.sendRedirect("doctors.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("action")) {
            case "create":
                createPatient(request);
                break;
            case "edit":
                editDoctor(request);
                break;
            case "delete":
                deleteDoctor(request);
                break;
            default:
                break;
        }
        getDoctor(request);
        response.sendRedirect("doctors.jsp");
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

    private List<Doctor> getDoctor(HttpServletRequest request) {
        List<Doctor> doctors = controladoraLogica.getDoctors();
        HttpSession mysession = request.getSession();
        mysession.setAttribute("doctors", doctors);
        return doctors;
    }

    private void createPatient(HttpServletRequest request) {
        try {
            String name = request.getParameter("name");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String specialty = request.getParameter("specialty");
            controladoraLogica.createDoctor(new Doctor(specialty, null, 0, "", name, lastName, null, phone, email));
        } catch (Exception ex) {
            Logger.getLogger(DoctorServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void editDoctor(HttpServletRequest request) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String specialty = request.getParameter("specialty");
            Doctor doctor = controladoraLogica.getDoctor(id);
            doctor.setName(name);
            doctor.setLastName(lastName);
            doctor.setPhone(phone);
            doctor.setEmail(email);
            doctor.setSpecialty(specialty);
            controladoraLogica.editDoctor(doctor);
        } catch (Exception ex) {
            Logger.getLogger(DoctorServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void deleteDoctor(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        controladoraLogica.deleteDoctor(id);
    }

}
