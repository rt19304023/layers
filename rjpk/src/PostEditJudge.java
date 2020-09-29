import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import postapp.DataBaseAccess;
import postapp.exception.EmptyInputtedException;
import postapp.parameter.Post;

public class PostEditJudge extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        String pw = request.getParameter("pw");
        String postNumber = request.getParameter("postnumber");
        Post post = null;

        // パスワードが空白の場合例外発生
        if(pw.equals("")) {
            throw new EmptyInputtedException();
        }

        boolean isPwCorrect = false;
        try {
        	DataBaseAccess access = (DataBaseAccess)property.CreateDataBaseInstance.getInstance("Oracle");

            post = access.postSelect(postNumber);

            if(pw.equals(post.getPw())) {
                isPwCorrect = true;
            }
            access.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }

        if(isPwCorrect) {
            response.sendRedirect("PostSelectServlet?postnumber="+postNumber+"&isedit=true");
        } else {
            request.setAttribute("postnumber", postNumber);
            RequestDispatcher dispatcher = request.getRequestDispatcher("pwincorrect");

            dispatcher.forward(request, response);
        }
    }
}
