package com.liuben.persistencia;

import com.liuben.logica.Doctor;
import com.liuben.logica.Patient;
import com.liuben.logica.Schedule;
import com.liuben.logica.User;
import com.liuben.persistencia.exceptions.NonexistentEntityException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author LiubenPC
 */
public class ControladoraPersistencia {

    UserJpaController userJpaController = new UserJpaController();
    DoctorJpaController doctorJpaController = new DoctorJpaController();
    PatientJpaController patientJpaController = new PatientJpaController();
    PersonJpaController personJpaController = new PersonJpaController();
    ScheduleJpaController scheduleJpaController = new ScheduleJpaController();

    public ControladoraPersistencia() {
    }

    //***** User *****
    public void createUser(User user) {
        userJpaController.create(user);
    }

    public List<User> getUsers() {
        return userJpaController.findUserEntities();
    }

    public User getUser(int id) {
        return userJpaController.findUser(id);
    }

    public void deleteUser(int id) {
        try {
            userJpaController.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void editUser(User user) {
        try {
            userJpaController.edit(user);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public User checkUserCredentials(String username, String password) {
        User user = null;
        try {
            user = userJpaController.checkUserCredentials(username, password);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    //***** Patient *****
    public void createPatient(Patient patient) {
        patientJpaController.create(patient);
    }

    public List<Patient> getPatients() {
        return patientJpaController.findPatientEntities();
    }

    public Patient getPatient(int id) {
        return patientJpaController.findPatient(id);
    }

    public void deletePatient(int id) {
        try {
            patientJpaController.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void editPatient(Patient patient) {
        try {
            patientJpaController.edit(patient);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    //***** Doctor *****
    public void createDoctor(Doctor doctor) {
        doctorJpaController.create(doctor);
    }

    public List<Doctor> getDoctors() {
        return doctorJpaController.findDoctorEntities();
    }

    public Doctor getDoctor(int id) {
        return doctorJpaController.findDoctor(id);
    }

    public void deleteDoctor(int id) {
        try {
            doctorJpaController.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void editDoctor(Doctor doctor) {
        try {
            doctorJpaController.edit(doctor);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //***** Schedule *****
    public void createSchedule(Schedule schedule) {
        scheduleJpaController.create(schedule);
    }
    
    public List<Schedule> getSchedules() {
        return scheduleJpaController.findScheduleEntities();
    }
    
    public Schedule getSchedule(int id) {
        return scheduleJpaController.findSchedule(id);
    }
    
    public void deleteSchedule(int id) {
        try {
            scheduleJpaController.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void editSchedule(Schedule schedule) {
        try {
            scheduleJpaController.edit(schedule);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
