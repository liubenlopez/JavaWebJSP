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
public class Patient extends Person implements Serializable {

    private String bloodType;
    @OneToMany(mappedBy = "patient", cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REMOVE})
    private List<Schedule> scheduleList;

    public Patient() {
    }

    public Patient(String bloodType, List<Schedule> scheduleList, int id, String nid, String name, String lastName, Date birthday, String phone, String email) {
        super(id, nid, name, lastName, birthday, phone, email);
        this.bloodType = bloodType;
        this.scheduleList = scheduleList;
    }

    public String getBloodType() {
        return bloodType;
    }

    public void setBloodType(String bloodType) {
        this.bloodType = bloodType;
    }

    public List<Schedule> getScheduleList() {
        return scheduleList;
    }

    public void setScheduleList(List<Schedule> scheduleList) {
        this.scheduleList = scheduleList;
    }

}
