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
      border: 2px solid black; /* Set border to 2px thick and black */
      border-collapse: collapse; /* Collapse border spacing */
    }
    th, td {
      border: 1px solid black; /* Ensure inner borders are visible */
      padding: 8px; /* Add padding for better readability */
    }
    thead {
      background-color: #3373ca; /* Set background color to blue */
      color: white; /* Set text color to white */
    }
    th {
      font-weight: normal; /* Set font weight to normal */
    }
    .center-text {
      text-align: center; /* Center text */
    }
    .department-col {
      width: 20%; /* Adjust as needed */
    }
    .student-id-col {
      width: 18%; /* Adjust as needed */
    }
    .marks-col {
      width: 10%; /* Adjust as needed */
    }
    .pass-percent-col {
      width: 10%; /* Adjust as needed */
    }
    /* Modal styles */
    .modal {
      display: none; /* Hidden by default */
      position: fixed; /* Stay in place */
      z-index: 1; /* Sit on top */
      left: 0;
      top: 0;
      width: 100%; /* Full width */
      height: 100%; /* Full height */
      overflow: auto; /* Enable scroll if needed */
      background-color: rgb(0,0,0); /* Fallback color */
      background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
      padding-top: 60px;
    }
    .modal-content {
      background-color: #fefefe;
      margin: 5% auto; /* 15% from the top and centered */
      padding: 20px;
      border: 1px solid #888;
      width: 80%; /* Could be more or less, depending on screen size */
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
        // Map to store passed student count per department
        Map<String, Integer> passedStudentsCount = new HashMap<>();
        Map<String, Integer> totalStudentsCount = new HashMap<>();
        Map<String, Double> passPercentageMap = new HashMap<>();

        // Iterate over students to calculate pass percentage
        for (Student student : students) {
          // Update total students count for the department
          if (!totalStudentsCount.containsKey(student.getDepartment())) {
            totalStudentsCount.put(student.getDepartment(), 0);
          }
          totalStudentsCount.put(student.getDepartment(), totalStudentsCount.get(student.getDepartment()) + 1);

          // Update passed students count for the department
          if (student.getMarks() >= 40) {
            if (!passedStudentsCount.containsKey(student.getDepartment())) {
              passedStudentsCount.put(student.getDepartment(), 0);
            }
            passedStudentsCount.put(student.getDepartment(), passedStudentsCount.get(student.getDepartment()) + 1);
          }
        }

        // Calculate pass percentage for each department
        for (String department : totalStudentsCount.keySet()) {
          int totalStudentsInDepartment = totalStudentsCount.get(department);
          int passedStudentsInDepartment = passedStudentsCount.getOrDefault(department, 0);

          double passPercentage = 0.0;
          if (totalStudentsInDepartment > 0) {
            passPercentage = (double) passedStudentsInDepartment / totalStudentsInDepartment * 100;
          }

          passPercentageMap.put(department, passPercentage);
        }

        // Keep track of the current department and row count for rowspan
        String currentDepartment = "";
        int departmentRowCount = 0;

        // Iterate again to output the table rows
        for (int i = 0; i < students.size(); i++) {
          Student student = students.get(i);
          String department = student.getDepartment();
          int marks = student.getMarks();

          // Update current department and row count for rowspan
          if (!department.equals(currentDepartment)) {
            currentDepartment = department;
            departmentRowCount = (int) students.stream().filter(s -> s.getDepartment().equals(department)).count();
          }

          // Format passPercentage to display as integer if no decimal places
          double passPercentage = passPercentageMap.get(department);
          String formattedPassPercentage = (passPercentage % 1 == 0) ? String.valueOf((int) passPercentage) : String.format("%.2f", passPercentage);

          // Build the table row
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

  <!-- The Modal -->
  <div id="myModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal()">&times;</span>
      <p id="studentNamePopup"></p>
    </div>
  </div>

</body>
</html>
