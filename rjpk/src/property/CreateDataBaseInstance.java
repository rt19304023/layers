package property;

import java.util.ResourceBundle;

public class CreateDataBaseInstance {
	private CreateDataBaseInstance() {
		// TODO 自動生成されたコンストラクター・スタブ
	}
	public static Object getInstance(String key) {
		Object instance = null;
		try {
			ResourceBundle resources = ResourceBundle.getBundle("property\\DataBaseAccessInstance");
			//prop.load(new FileInputStream(resources.getString("Oracle"));
			String name = resources.getString(key);
			Class c = Class.forName(name);
			instance = c.newInstance();
		}catch(InstantiationException e){
			e.printStackTrace();
		}catch(IllegalAccessException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
		return instance;
	}
}
