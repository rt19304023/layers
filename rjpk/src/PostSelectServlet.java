

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import postapp.DataBaseAccess;
import postapp.StringFormatter;
import postapp.parameter.Post;
import postapp.parameter.Reply;



public class PostSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");

		String postNumber = request.getParameter("postnumber");
		boolean isEdit = request.getParameter("isedit").equals("true");

		Post post = new Post();
		ArrayList<Reply> comments = new ArrayList<Reply>();

		try {
			DataBaseAccess access = (DataBaseAccess)property.CreateDataBaseInstance.getInstance("Oracle");
		    post = access.postSelect(postNumber);
		    comments = access.allCommentsSelect(postNumber);
		    access.disconnect();
		  } catch (Exception e) {
		    e.printStackTrace();
		  }


		  /*String title = post.getTitle();
		  String author = post.getAuthor();
		  String date = post.getDate();
		  String content = post.getContent();*/
		  String htmlContent = StringFormatter.htmlLineFormat(post.getContent());
		  HashSet<String> tags = null;



		  boolean hasTag = true;
		  if (post.getTags() == null) {
		    hasTag = false;
		  } else {
		    tags = StringFormatter.tagsFix(post.getTags());
		  }

		  request.setAttribute("htmlContent",htmlContent);
		  request.setAttribute("postNumber",postNumber);
		  request.setAttribute("tags",tags);
		  request.setAttribute("hasTag",hasTag);
		  request.setAttribute("isEdit",isEdit);
		  request.setAttribute("post",post);

		  boolean hasComment = true;

		  if (comments.size() < 1) {
		    hasComment = false;
		  }

		  request.setAttribute("hasComment",hasComment);
		  RequestDispatcher dispatchar = request.getRequestDispatcher("postview.jsp");
		    dispatchar.forward(request, response);
	}

}
