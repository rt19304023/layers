import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import postapp.DataBaseAccess;
import postapp.parameter.Post;

public class GetMorePosts extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int lastPrintedPost = Integer.parseInt(request.getParameter("lastestpost"));
        int showingPostNum = Integer.parseInt(request.getParameter("showingposts"));
        JSONObject root = new JSONObject();
        JSONArray postArray = new JSONArray();
        JSONObject postData = new JSONObject();

        ArrayList<Post> postList = new ArrayList<Post>();

        try {
        	DataBaseAccess access = (DataBaseAccess)property.CreateDataBaseInstance.getInstance("Oracle");
            postList = access.postSelect(lastPrintedPost+1, lastPrintedPost+showingPostNum);
            access.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }

        if(postList.size()==0) {
            root.put("hasData", false);
        } else {
            for (Post post : postList) {
                postData = new JSONObject();

                postData.put("postnumber", post.getPostNumber());
                postData.put("title", post.getTitle());
                postData.put("author", post.getAuthor());
                postData.put("date", post.getDate());
                postData.put("content", post.getContent());

                postArray.add(postData);
            }
            root.put("hasData", true);
            root.put("posts", postArray);
        }

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/x-json charset=UTF-8");
        response.getWriter().print(root);
    }
}
