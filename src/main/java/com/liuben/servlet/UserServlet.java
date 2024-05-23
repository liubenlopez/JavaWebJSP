package com.liuben.servlet;

import com.liuben.logica.ControladoraLogica;
import com.liuben.logica.User;
import java.io.IOException;
import java.util.List;
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
@WebServlet(name = "UserServlet", urlPatterns = {"/UserServlet"})
public class UserServlet extends HttpServlet {

    ControladoraLogica controladoraLogica = new ControladoraLogica();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        getUsers(request);
        response.sendRedirect("users.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("action")) {
            case "create":
                createUser(request);
                break;
            case "edit":
                editUser(request);
                break;
            case "delete":
                deleteUser(request);
                break;
            default:
                break;
        }
        getUsers(request);
        response.sendRedirect("users.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private List<User> getUsers(HttpServletRequest request) {
        List<User> users = controladoraLogica.getUsers();
        for (User user : users) {
            if (user.getUsername().equals("admin") && user.getRole().equals("admin")) {
                users.remove(user);
                break;
            }
        }
        HttpSession mysession = request.getSession();
        mysession.setAttribute("users", users);
        return users;
    }

    private void createUser(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if (username != null && password != null) {
            controladoraLogica.createUser(new User(0, username, password, ""));
        } else {
            String fallo = "";
        }
    }

    private void editUser(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = controladoraLogica.getUser(id);
        user.setUsername(username);
        user.setPassword(password);
        controladoraLogica.editUser(user);
    }

    private void deleteUser(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        controladoraLogica.deleteUser(id);
    }

}
