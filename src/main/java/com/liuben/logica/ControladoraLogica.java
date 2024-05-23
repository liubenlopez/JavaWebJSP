package com.liuben.logica;

import com.liuben.persistencia.ControladoraPersistencia;
import java.util.List;

/**
 *
 * @author LiubenPC
 */
public class ControladoraLogica {

    ControladoraPersistencia controladoraPersistencia = new ControladoraPersistencia();

    public ControladoraLogica() {
    }

    //***** User *****
    public void createUser(User user) {
        controladoraPersistencia.createUser(user);
    }

    public List<User> getUsers() {
        return controladoraPersistencia.getUsers();
    }

    public User getUser(int id) {
        return controladoraPersistencia.getUser(id);
    }

    public void deleteUser(int id) {
        controladoraPersistencia.deleteUser(id);
    }

    public void editUser(User user) {
        controladoraPersistencia.editUser(user);
    }

    public User checkUserCredentials(String username, String password) {
        return controladoraPersistencia.checkUserCredentials(username, password);
    }

    //***** Patient *****
    public void createPatient(Patient patient) {
        controladoraPersistencia.createPatient(patient);
    }

    public List<Patient> getPatients() {
        return controladoraPersistencia.getPatients();
    }

    public Patient getPatient(int id) {
        return controladoraPersistencia.getPatient(id);
    }

    public void deletePatient(int id) {
        controladoraPersistencia.deletePatient(id);
    }

    public void editPatient(Patient patient) {
        controladoraPersistencia.editPatient(patient);
    }

    //***** Doctor *****
    public void createDoctor(Doctor doctor) {
        controladoraPersistencia.createDoctor(doctor);
    }

    public List<Doctor> getDoctors() {
        return controladoraPersistencia.getDoctors();
    }

    public Doctor getDoctor(int id) {
        return controladoraPersistencia.getDoctor(id);
    }

    public void deleteDoctor(int id) {
        controladoraPersistencia.deleteDoctor(id);
    }

    public void editDoctor(Doctor doctor) {
        controladoraPersistencia.editDoctor(doctor);
    }

    //***** Schedule *****
    public void createSchedule(Schedule schedule) {
        controladoraPersistencia.createSchedule(schedule);
    }

    public List<Schedule> getSchedules() {
        return controladoraPersistencia.getSchedules();
    }

    public Schedule getSchedule(int id) {
        return controladoraPersistencia.getSchedule(id);
    }
    
    public void deleteSchedule(int id) {
        controladoraPersistencia.deleteSchedule(id);
    }

    public void editSchedule(Schedule schedule) {
        controladoraPersistencia.editSchedule(schedule);
    }

}
