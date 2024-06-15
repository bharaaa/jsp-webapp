package org.example;

public class Student {
    private String department;
    private String studentId;
    private String studentName;
    private int marks;

    public Student(String department, String studentId, String studentName, int marks) {
        this.department = department;
        this.studentId = studentId;
        this.studentName = studentName;
        this.marks = marks;
    }

    public String getDepartment() {
        return department;
    }

    public String getStudentID() {
        return studentId;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public int getMarks() {
        return marks;
    }

    public void setMarks(int marks) {
        this.marks = marks;
    }
}
