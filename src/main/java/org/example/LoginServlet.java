package org.example;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet {

    private final String username = "admin"; // Hardcoded username
    private final String password = "secret"; // Hardcoded password
    private final List<Student> students = getStudentList(); // Hardcoded student data

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        // Simple validation with hardcoded credentials
        if (username.equals(userId) && password.equals(password)) {
            Student specificStudent = findCurrentStudent(userId);
            request.setAttribute("students", students);
            request.setAttribute("currentStudent", specificStudent);
            request.getRequestDispatcher("/welcome.jsp").forward(request, response);
        } else {
            response.getWriter().write("Invalid user ID or password.");
        }
    }

    private List<Student> getStudentList() {
        List<Student> students = new ArrayList<>();
        students.add(new Student("Dep 1", "S1", "Adi", 35));
        students.add(new Student("Dep 1", "S2", "Budi", 70));
        students.add(new Student("Dep 1", "S3", "Anya", 60));
        students.add(new Student("Dep 1", "S4", "Sinya", 90));
        students.add(new Student("Dep 2", "S5", "Yuan", 30));
        students.add(new Student("Dep 3", "S6", "Pepe", 32));
        students.add(new Student("Dep 3", "S7", "Mumu", 70));
        students.add(new Student("Dep 3", "S8", "Sisi", 20));
        return students;
    }

    private Student findCurrentStudent(String userId) {
        for (Student student : students) {
            if (student.getStudentID().equals(userId)) {  // Replace with your logic
                return student;
            }
        }
        return null;
    }
}
