package postlist;

import java.util.ArrayList;

import postapp.DataBaseAccess;
import postapp.parameter.Post;

public class TitleAbridgement {

	public ArrayList<Post> abridgement(){
		ArrayList<Post> postBuff = new ArrayList<Post>();
		  try {
			  DataBaseAccess access = (DataBaseAccess)property.CreateDataBaseInstance.getInstance("Oracle");
		    postBuff = access.postSelect(5);
		    access.disconnect();
		  } catch (Exception e) {
		    e.printStackTrace();
		  }


		  return postBuff;
	}
}
