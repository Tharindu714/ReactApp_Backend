package controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import entity.Chat;
import entity.User;
import entity.User_Status;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.HibernateUtil;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

@WebServlet(name = "LoadHomeData", urlPatterns = {"/LoadHomeData"})
public class LoadHomeData extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject responseJson = new JsonObject();
        responseJson.addProperty("status", false);
        responseJson.addProperty("message", "Unable to process your contact");
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            //Get User Id from request parameter
            String userID = request.getParameter("id");

            //Get User Object
            User user = (User) session.get(User.class, Integer.parseInt(userID));

            //Get user_status = 1 Online
            User_Status user_status = (User_Status) session.get(User_Status.class, 1);

            //Update user Status
            user.setUser_Status(user_status);
            session.update(user);

            //Get other users
            Criteria criteria1 = session.createCriteria(User.class);
            criteria1.add(Restrictions.ne("id", user.getId()));

            List<User> otherUserList = criteria1.list();

            JsonArray jsonChatArray = new JsonArray();

            for (User otherUser : otherUserList) {
                //Start of Get Chats
                Criteria criteria2 = session.createCriteria(Chat.class);
                criteria2.add(
                        Restrictions.or(
                                Restrictions.and(
                                        Restrictions.eq("from_user", user),
                                        Restrictions.eq("to_user", otherUser)
                                ),
                                Restrictions.and(
                                        Restrictions.eq("from_user", otherUser),
                                        Restrictions.eq("to_user", user)
                                )
                        )
                );
                criteria2.addOrder(Order.desc("id"));
                criteria2.setMaxResults(1);

                //Create Chat  item JSON to send frontend data
                JsonObject chatItem = new JsonObject();
                chatItem.addProperty("other_user_id", otherUser.getId());
                chatItem.addProperty("other_user_mobile", otherUser.getMobile());
                chatItem.addProperty("other_user_name", otherUser.getFirst_name() + " " + otherUser.getLast_name());
                chatItem.addProperty("other_user_status", otherUser.getUser_Status().getId());

                //Check Avater Image
                String serverPath = request.getServletContext().getRealPath("");
                String avaterImagePath = serverPath + "build" + File.separator + "web";
                String folder = avaterImagePath + File.separator + "Avater" + File.separator + otherUser.getFirst_name() + " " + otherUser.getLast_name() + ".png";
                File OtherUserImage = new File(folder + otherUser.getFirst_name() + "_" + otherUser.getLast_name() + "_image.png");

                if (OtherUserImage.exists()) {
                    //avatar Image found
                    chatItem.addProperty("avater_image_found", true);
                } else {
                    chatItem.addProperty("avater_image_found", false);
                    chatItem.addProperty("other_user_avatar_letter", otherUser.getFirst_name().charAt(0) + "" + otherUser.getLast_name().charAt(0));
                }
                //get Chat List
                List<Chat> chatList = criteria2.list();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy, MMM dd hh:mm:ss a");

                if (chatList.isEmpty()) {
                    //No Conversation Found
                    chatItem.addProperty("message", "Let's Start new Conversation !!");
                    chatItem.addProperty("dateTime", dateFormat.format(user.getRegistered_date_time()));
                    chatItem.addProperty("chat_status_id", 1);
                } else {
                    chatItem.addProperty("message", chatList.get(0).getMessage());
                    chatItem.addProperty("dateTime", dateFormat.format(chatList.get(0).getDate_time()));
                    chatItem.addProperty("chat_status_id", chatList.get(0).getChat_Status().getId());
                }
                //get Last Conversation
                jsonChatArray.add(chatItem);

            }
            //Using Projections will remove all user chats
            //criteria2.setProjection(Projections.distinct(Projections.property("")));

            //Send User
            responseJson.addProperty("status", true);
            responseJson.addProperty("message", "Success");
            responseJson.addProperty("user", gson.toJson(user));
            responseJson.addProperty("otherUserList", gson.toJson(otherUserList));
            responseJson.addProperty("jsonChatArray", gson.toJson(jsonChatArray));

            session.beginTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.setContentType("application/json");
        response.getWriter().write(gson.toJson(responseJson));

    }

}
