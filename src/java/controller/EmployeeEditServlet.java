/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import business.FormValidation;
import business.Person;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.DateUtil;

/**
 *
 * @author Bill Adams
 */
public class EmployeeEditServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = "/index.jsp";
        ArrayList<String> messages = new ArrayList<String>();
        HttpSession session = request.getSession();
        String birthDateInputString = null;
        String hireDateInputString = null;
        boolean isUpdate = false;
        // Set employeeList arrayIndex to -1 to indicate it hasn't been set.
        int arrayIndex = -1;
        
        String action = request.getParameter("action");
        if (action.equals("first")) {
            url = "/index.jsp";
            session.setAttribute("isUpdate", isUpdate);
        } 
        else if (action.equals("addEmployee")) {
            String validationMessage = "";
            LocalDate birthDate = null;
            LocalDate hireDate = null;

            try {
                arrayIndex = Integer.parseInt(request.getParameter("arrayIndex"));
            } catch (NumberFormatException e) {
                arrayIndex = -1;
            }

            // Validate the form input.
            String firstName = request.getParameter("firstName");
            validationMessage = FormValidation.validateStringInput(firstName, "First name");
            if (!validationMessage.equals("")) {
                messages.add(validationMessage);
            }

            String middleName = request.getParameter("middleName");

            String lastName = request.getParameter("lastName");
            validationMessage = FormValidation.validateStringInput(lastName, "Last name");
            if (!validationMessage.equals("")) {
                messages.add(validationMessage);
            }

            String employeeID = request.getParameter("employeeID");
            validationMessage = FormValidation.validateIntegerInput(employeeID, "Employee ID");
            if (!validationMessage.equals("")) {
                messages.add(validationMessage);
            }

            String birthDateString = request.getParameter("birthDate");
            validationMessage = FormValidation.validateDateInput(birthDateString, "Birth date");
            if (!validationMessage.equals("")) {
                messages.add(validationMessage);
            } else {
                birthDate = LocalDate.parse(birthDateString);
                birthDateInputString = DateUtil.createFormattedDateInputString(birthDate);
            }

            String hireDateString = request.getParameter("hireDate");
            validationMessage = FormValidation.validateDateInput(hireDateString, "Hire date");
            if (!validationMessage.equals("")) {
                messages.add(validationMessage);
            } else {
                hireDate = LocalDate.parse(hireDateString);
                hireDateInputString = DateUtil.createFormattedDateInputString(hireDate);
            }

            // If messages comes back empty (i.e. everything validated), create 
            // or update the person collection and add it to the session.
            if (messages.isEmpty()) {
                if (arrayIndex == -1) {

                    // Add a new employee.
                    employeeList.add(new Person(firstName, middleName, lastName, employeeID, birthDate, hireDate));
                    session.setAttribute("employeeList", employeeList);
                    session.setAttribute("isUpdate", isUpdate);
                } else {

                    // Update an existing employee.
                    employeeList = (ArrayList<Person>) session.getAttribute("employeeList");
                    Person employeeToEdit = employeeList.get(arrayIndex);

                    employeeToEdit.setFirstName(firstName);
                    employeeToEdit.setMiddleName(middleName);
                    employeeToEdit.setLastName(lastName);
                    employeeToEdit.setEmployeeID(employeeID);
                    employeeToEdit.setBirthDate(birthDate);
                    employeeToEdit.setHireDate(hireDate);
                }
            } else {
                // Set attributes the user completed and return them 
                // to the form during the validation process.
                request.setAttribute("firstName", firstName);
                request.setAttribute("middleName", middleName);
                request.setAttribute("lastName", lastName);
                request.setAttribute("employeeID", employeeID);
                request.setAttribute("birthDateInputString", birthDateInputString);
                request.setAttribute("hireDateInputString", hireDateInputString);

                if (arrayIndex != -1) {
                    request.setAttribute("employeeIndex", arrayIndex);
                    isUpdate = true;
                    session.setAttribute("isUpdate", isUpdate);
                }

                request.setAttribute("messages", messages);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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

}
