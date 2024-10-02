package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import entity.User;
import entity.User_Status;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.HibernateUtil;
import model.Validations;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

@MultipartConfig
@WebServlet(name = "SignUp", urlPatterns = {"/SignUp"})
public class SignUp extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject responseJson = new JsonObject();
        responseJson.addProperty("success", false);

        String mobile = request.getParameter("mobile");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String password = request.getParameter("password");
        Part avatarImage = request.getPart("avatarImage");

        if (mobile.isEmpty()) {
            responseJson.addProperty("message", "Please Fill Mobile Number");

        } else if (!Validations.isMobileNumberValid(mobile)) {
            responseJson.addProperty("message", "Invalid Mobile Number");

        } else if (firstName.isEmpty()) {
            responseJson.addProperty("message", "Please Fill First Name");

        } else if (lastName.isEmpty()) {
            responseJson.addProperty("message", "Please Fill Last Name");

        } else if (password.isEmpty()) {
            responseJson.addProperty("message", "Please Fill Your Password");

        } else if (!Validations.isPasswordValid(password)) {
            responseJson.addProperty("message", "Password Musr include atleast on UPPER_CASE letter, NUMBER, Special Character & be atleast 8 Charaters long");

        } else {
            Session session = HibernateUtil.getSessionFactory().openSession();

            Criteria criteria1 = session.createCriteria(User.class);
            criteria1.add(Restrictions.eq("mobile", mobile));

            if (!criteria1.list().isEmpty()) {
            responseJson.addProperty("message", "Mobile Number already Used");

            } else {
                User user = new User();
                user.setFirst_name(firstName);
                user.setLast_name(lastName);
                user.setMobile(mobile);
                user.setPassword(password);
                user.setRegistered_date_time(new Date());

                User_Status user_status = (User_Status) session.get(User_Status.class, 2);
                user.setUser_Status(user_status);

                session.save(user);
                session.beginTransaction().commit();

                if (avatarImage.getSubmittedFileName() != null) {
                    String serverPath = request.getServletContext().getRealPath("");
                    String avaterImagePath = serverPath.replace("build" + File.separator + "web", "web");

                    File folder = new File(avaterImagePath + File.separator + "Avater" + File.separator + firstName + " " + lastName + ".png");
                    folder.mkdir();

                    File file1 = new File(folder, firstName + "_" + lastName + "_image.png");
                    InputStream inputStream = avatarImage.getInputStream();
                    Files.copy(inputStream, file1.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
            }

            responseJson.addProperty("success", true);
            responseJson.addProperty("message", "Registration Complete");
            session.close();
        }

        response.setContentType("application/json");
        response.getWriter().write(gson.toJson(responseJson));
    }

}
