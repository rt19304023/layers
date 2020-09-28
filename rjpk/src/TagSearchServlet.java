

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import postapp.DataBaseAccess;
import postapp.parameter.Post;

/**
 * Servlet implementation class TagSearchServlet
 */
@WebServlet("/TagSearchServlet")
public class TagSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		request.setCharacterEncoding("utf-8");

		String tagName = request.getParameter("search");

		ArrayList<Post> searchedPost = new ArrayList<Post>();

		boolean isEmpty = false;
		try {
			DataBaseAccess access = (DataBaseAccess)property.CreateDataBaseInstance.getInstance("Oracle");

		    ArrayList<String> postNumberList =  access.tagSelect(tagName);

		    for(String postNumber : postNumberList) {
		        Post post = access.postSelect(postNumber);
		        searchedPost.add(post);
		    }
		    if(searchedPost.size()<1) {
		        isEmpty = true;
		    }

		    access.disconnect();

		    request.setAttribute("tagName", tagName);
		    request.setAttribute("isEmpty", isEmpty);
		    request.setAttribute("searchedPost", searchedPost);


		  } catch (Exception e) {
		      e.printStackTrace();
		  }
		RequestDispatcher dispatchar = request.getRequestDispatcher("searchresult.jsp");
	    dispatchar.forward(request, response);
	}

}
