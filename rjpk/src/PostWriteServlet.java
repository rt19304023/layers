import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import postapp.DataBaseAccess;
import postapp.StringFormatter;
import postapp.exception.DataEmptyException;
import postapp.exception.EmptyInputtedException;

public class PostWriteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        String title = StringFormatter.sqlEscape(request.getParameter("title"));
        String author = StringFormatter.sqlEscape(request.getParameter("author"));
        String content = StringFormatter.sqlEscape(request.getParameter("content"));
        String pw = StringFormatter.sqlEscape(request.getParameter("pw"));
        String tags = StringFormatter.sqlEscape(request.getParameter("tags"));

        // 入力されたパラメータが空白の場合例外発生
        if(title.equals("") || content.equals("") || pw.equals("")) {
            throw new EmptyInputtedException();
        }

        String curval = null;
        try {
        	DataBaseAccess access = (DataBaseAccess)property.CreateDataBaseInstance.getInstance("Oracle");

            if(tags.equals("") && author.equals("")) {   //
                access.postInsert("匿名", pw, title, content);
            } else if(author.equals("")){
                access.postInsert("匿名", pw, title, content, tags.replaceAll("[ 　]",""));
            } else if(tags.equals("")){
              access.postInsert(author, pw, title, content);
            } else {
              access.postInsert(author, pw, title, content, tags.replaceAll("[ 　]",""));
            }
            curval = access.getCurVal();

            access.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // [curval]に値がない場合例外発生
        if(curval==null) {
            throw new DataEmptyException();
        }

        response.sendRedirect("PostSelectServlet?postnumber="+curval+"&isedit=false");
    }
}
