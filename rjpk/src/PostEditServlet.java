import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import postapp.DataBaseAccess;
import postapp.exception.EmptyInputtedException;

public class PostEditServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        String content = request.getParameter("content");
        String postNumber = request.getParameter("postnumber");

        // パスワードが空白の場合例外発生
        if(content.equals("")) {
            throw new EmptyInputtedException();
        }

        try {
        	DataBaseAccess access = (DataBaseAccess)property.CreateDataBaseInstance.getInstance("Oracle");

            access.postUpdate(postNumber, content);

            access.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("postview?postnumber="+postNumber+"&isedit=false");
    }
}
