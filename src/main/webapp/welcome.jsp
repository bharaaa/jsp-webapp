<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.Student" %>
<!DOCTYPE html>
<html>
<head>
  <title>Student Information</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    table {
      border: 2px solid black;
      border-collapse: collapse;
    }
    th, td {
      border: 1px solid black;
      padding: 8px;
    }
    thead {
      background-color: #3373ca;
      color: white;
    }
    th {
      font-weight: normal;
    }
    .center-text {
      text-align: center;
    }
    .department-col {
      width: 20%;
    }
    .student-id-col {
      width: 18%;
    }
    .marks-col {
      width: 10%;
    }
    .pass-percent-col {
      width: 10%;
    }

    .modal {
      display: none;
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgb(0,0,0);
      background-color: rgba(0,0,0,0.4);
      padding-top: 60px;
    }
    .modal-content {
      background-color: #fefefe;
      margin: 5% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 80%;
      border-radius: 20px;
    }
    .close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }
    .close:hover,
    .close:focus {
      color: black;
      text-decoration: none;
      cursor: pointer;
    }
  </style>
  <script type="text/javascript">
    function showStudentName(studentName) {
      document.getElementById('studentNamePopup').innerText = studentName;
      document.getElementById('myModal').style.display = "block";
    }

    function closeModal() {
      document.getElementById('myModal').style.display = "none";
    }

    window.onclick = function(event) {
      var modal = document.getElementById('myModal');
      if (event.target == modal) {
        modal.style.display = "none";
      }
    }
  </script>
</head>
<body>
  <h1>Student Information</h1>
  <% String userId = (String) request.getAttribute("userId"); %>
    <p style="font-size: 18px;">Welcome <%= userId %></p>
  <% List<Student> students = (List<Student>) request.getAttribute("students"); %>
  <% if (students != null) { %>
  <table>
    <thead>
      <tr>
        <th class="center-text department-col">Department</th>
        <th class="student-id-col">Student ID</th>
        <th class="marks-col">Marks</th>
        <th class="center-text pass-percent-col">Pass %</th>
      </tr>
    </thead>
    <tbody>
      <%
        Map<String, Integer> passedStudentsCount = new HashMap<>();
        Map<String, Integer> totalStudentsCount = new HashMap<>();
        Map<String, Double> passPercentageMap = new HashMap<>();

        for (Student student : students) {
          if (!totalStudentsCount.containsKey(student.getDepartment())) {
            totalStudentsCount.put(student.getDepartment(), 0);
          }
          totalStudentsCount.put(student.getDepartment(), totalStudentsCount.get(student.getDepartment()) + 1);

          if (student.getMarks() >= 40) {
            if (!passedStudentsCount.containsKey(student.getDepartment())) {
              passedStudentsCount.put(student.getDepartment(), 0);
            }
            passedStudentsCount.put(student.getDepartment(), passedStudentsCount.get(student.getDepartment()) + 1);
          }
        }

        for (String department : totalStudentsCount.keySet()) {
          int totalStudentsInDepartment = totalStudentsCount.get(department);
          int passedStudentsInDepartment = passedStudentsCount.getOrDefault(department, 0);

          double passPercentage = 0.0;
          if (totalStudentsInDepartment > 0) {
            passPercentage = (double) passedStudentsInDepartment / totalStudentsInDepartment * 100;
          }

          passPercentageMap.put(department, passPercentage);
        }

        String currentDepartment = "";
        int departmentRowCount = 0;

        for (int i = 0; i < students.size(); i++) {
          Student student = students.get(i);
          String department = student.getDepartment();
          int marks = student.getMarks();

          if (!department.equals(currentDepartment)) {
            currentDepartment = department;
            departmentRowCount = (int) students.stream().filter(s -> s.getDepartment().equals(department)).count();
          }

          double passPercentage = passPercentageMap.get(department);
          String formattedPassPercentage = (passPercentage % 1 == 0) ? String.valueOf((int) passPercentage) : String.format("%.2f", passPercentage);

          out.print("<tr>");
          if (i == 0 || !students.get(i - 1).getDepartment().equals(department)) {
            out.print("<td class='center-text' rowspan='" + departmentRowCount + "'>" + department + "</td>");
          }
          out.print("<td><a href='#' onclick=\"showStudentName('" + student.getStudentName() + "')\"><strong>" + student.getStudentID() + "</strong></a></td>");
          out.print("<td>" + marks + "</td>");
          if (i == 0 || !students.get(i - 1).getDepartment().equals(department)) {
            out.print("<td class='center-text' rowspan='" + departmentRowCount + "'>" + formattedPassPercentage + "</td>");
          }
          out.print("</tr>");
        }
      %>
    </tbody>
  </table>
  <% } else { %>
    <p>Invalid login credentials.</p>
  <% } %>

  <div id="myModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal()">&times;</span>
      <p id="studentNamePopup"></p>
    </div>
  </div>

</body>
</html>
