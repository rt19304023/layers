package postapp;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;

import postapp.parameter.Post;
import postapp.parameter.Reply;

public interface DataBaseAccess {


	public void disconnect() throws SQLException;
	public String getCurVal() throws ServletException, SQLException;
	public ArrayList<Post> postSelect() throws SQLException;
	public ArrayList<Post> postSelect(int num) throws SQLException;
	public ArrayList<Post> postSelect(int startNum, int endNum) throws SQLException;
	public Post postSelect(String postNumber) throws SQLException;
	public int howManyPosts() throws SQLException;
	public void postInsert(String author, String pw, String title, String content) throws SQLException;
	public void postInsert(String author, String pw, String title, String content, String tags) throws SQLException;
	public void postDelete(String postNumber) throws SQLException;
	public void postUpdate(String postNumber, String content) throws SQLException;
	public ArrayList<Reply> allCommentsSelect(String postNumber) throws SQLException;
	public String commentPwSelect(String replyNumber) throws SQLException;
	public void commentInsert(String postNumber, String author, String pw, String content) throws SQLException;
	public void commentDelete(String replyNumber) throws SQLException;
	public ArrayList<String> tagSelect(String tagName) throws SQLException;


}
