package controller;

import entity.Chat_Status;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.HibernateUtil;
import org.hibernate.Session;

@WebServlet(name = "Test", urlPatterns = {"/Test"})
public class Test extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            Chat_Status chat_status = new Chat_Status();
            chat_status.setName("Seen");
            
            session.save(chat_status);
            session.beginTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
