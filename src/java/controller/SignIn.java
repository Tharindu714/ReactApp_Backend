package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import entity.User;
import entity.User_Status;
import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.HibernateUtil;
import model.Validations;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

@WebServlet(name = "SignIn", urlPatterns = {"/SignIn"})
public class SignIn extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject responseJson = new JsonObject();
        responseJson.addProperty("Success", false);

        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");

        if (mobile.isEmpty()) {
            responseJson.addProperty("message", "Please Fill Mobile Number");

        } else if (!Validations.isMobileNumberValid(mobile)) {
            responseJson.addProperty("message", "Invalid Mobile Number");

        } else if (password.isEmpty()) {
            responseJson.addProperty("message", "Please Fill Your Password");

        } else {
            Session session = HibernateUtil.getSessionFactory().openSession();

            Criteria criteria1 = session.createCriteria(User.class);
            criteria1.add(Restrictions.eq("mobile", mobile));
            criteria1.add(Restrictions.eq("password", password));

            if (!criteria1.list().isEmpty()) {
                User user = (User) criteria1.uniqueResult();

                responseJson.addProperty("Success", true);
                responseJson.addProperty("message", "SignIN Success");
                responseJson.add("user", gson.toJsonTree(user));

            } else {
                responseJson.addProperty("message", "Invalid Credentials");
            }

            responseJson.addProperty("Success", true);
            responseJson.addProperty("message", "Registration Complete");
            session.close();
        }

        response.setContentType("application/json");
        response.getWriter().write(gson.toJson(responseJson));
    }

}
