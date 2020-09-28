import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import postapp.DataBaseAccess;
import postapp.exception.EmptyInputtedException;
import postapp.parameter.Post;

public class PostDeleteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        String pw = request.getParameter("pw");
        String postNumber = request.getParameter("postnumber");

        // パスワードが空白の場合例外発生
        if(pw.equals("")) {
            throw new EmptyInputtedException();
        }

        boolean isDeleted = false;
        try {
        	DataBaseAccess access = (DataBaseAccess)property.CreateDataBaseInstance.getInstance("Oracle");

            Post post = access.postSelect(postNumber);

            if(post.getPw().equals(pw)) {
                access.postDelete(postNumber);
                isDeleted = true;
            }
            access.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher dispatcher;
        if(isDeleted) {
            dispatcher = request.getRequestDispatcher("deletesuccess");
        } else {
            request.setAttribute("postnumber", postNumber);
            dispatcher = request.getRequestDispatcher("pwincorrect");
        }

        dispatcher.forward(request, response);
    }
}