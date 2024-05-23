package com.liuben.logica;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToMany;

/**
 *
 * @author LiubenPC
 */
@Entity
public class Doctor extends Person implements Serializable {

    private String specialty;
    @OneToMany(mappedBy = "doctor", cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REMOVE})
    private List<Schedule> scheduleList;

    public Doctor() {
    }

    public Doctor(String specialty, List<Schedule> scheduleList, int id, String nid, String name, String lastName, Date birthday, String phone, String email) {
        super(id, nid, name, lastName, birthday, phone, email);
        this.specialty = specialty;
        this.scheduleList = scheduleList;
    }

    public String getSpecialty() {
        return specialty;
    }

    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

    public List<Schedule> getScheduleList() {
        return scheduleList;
    }

    public void setScheduleList(List<Schedule> scheduleList) {
        this.scheduleList = scheduleList;
    }

}
