package postapp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;

import javax.servlet.ServletException;

import postapp.exception.DataEmptyException;
import postapp.parameter.Post;
import postapp.parameter.Reply;


public class OracleAccess implements DataBaseAccess{
    private static final String DATABASE_CLASS = "oracle.jdbc.driver.OracleDriver";
    private static final String DATABASE_LOGIN_INFO = "jdbc:oracle:thin:@localhost:1521:orcl";
    private static final String DATABASE_LOGIN_USER = "dduser";
    private static final String DATABASE_LOGIN_PW = "dduser";
    private Connection connection;

    // コンストラクタで Connection 初期化
    public OracleAccess() throws ClassNotFoundException, SQLException {
        Class.forName(DATABASE_CLASS);

        connection = DriverManager.getConnection(DATABASE_LOGIN_INFO,
                DATABASE_LOGIN_USER, DATABASE_LOGIN_PW);
    }

    // Connectionをcloseする
    public void disconnect() throws SQLException {
        connection.close();
    }

    // [POSTNUMSEQ.CURVAL]をリターン     注意点 : [CURVAL]は同じ接続で先に[NEXTVAL]を使用しないと使えない
    public String getCurVal() throws ServletException, SQLException {
        String curval = "";

        String sql = "SELECT postnumseq.currval FROM dual";

        ResultSet resultSet = connection.createStatement().executeQuery(sql);

        resultSet.next();
        curval = resultSet.getString(1);

        if(curval.equals("")) {
            throw new DataEmptyException();
        }

        return curval;
    }


    /* --掲示物-- */
    // 作成日にソートした掲示物リストをリターン
    public ArrayList<Post> postSelect() throws SQLException {
        ArrayList<Post> posts = new ArrayList<Post>();

        String sql = "SELECT postnumber, author, title, TO_CHAR(writtendate, 'yyyy-mm-dd hh24:mi'), content " +
                "FROM postlist ORDER BY writtendate DESC";

        ResultSet resultSet = connection.createStatement().executeQuery(sql);

        while (resultSet.next()) {
            Post post = new Post();

            post.setPostNumber(resultSet.getString(1));
            post.setAuthor(resultSet.getString(2));
            post.setTitle(resultSet.getString(3));
            post.setDate(resultSet.getString(4));
            post.setContent(resultSet.getString(5));

            posts.add(post);
        }

        return posts;
    }
    // 指定した数どおり掲示物のリストをリターン
    public ArrayList<Post> postSelect(int num) throws SQLException {
        ArrayList<Post> posts = new ArrayList<Post>();

        String sql = "SELECT postnumber, author, title, TO_CHAR(writtendate, 'yyyy-mm-dd hh24:mi'), content, " +
                "rownum FROM (SELECT * from postlist ORDER BY writtendate DESC)" +
                "WHERE rownum<="+num;

        ResultSet resultSet = connection.createStatement().executeQuery(sql);

        while(resultSet.next()) {
            Post post = new Post();

            post.setPostNumber(resultSet.getString(1));
            post.setAuthor(resultSet.getString(2));
            post.setTitle(resultSet.getString(3));
            post.setDate(resultSet.getString(4));
            post.setContent(resultSet.getString(5));

            posts.add(post);
        }

        return posts;
    }
    // 指定した範囲で掲示物のリストをリターン
    public ArrayList<Post> postSelect(int startNum, int endNum) throws SQLException {
        ArrayList<Post> posts = new ArrayList<Post>();

        String sql = "SELECT * FROM (SELECT POSTNUMBER, AUTHOR, TITLE, TO_CHAR(writtendate, 'yyyy-mm-dd hh24:mi'), " +
                "content, rownum as rn FROM (SELECT * from postlist ORDER BY writtendate DESC))" +
                "WHERE rn BETWEEN "+startNum+" AND "+endNum;

        ResultSet resultSet = connection.createStatement().executeQuery(sql);

        while(resultSet.next()) {
            Post post = new Post();

            post.setPostNumber(resultSet.getString(1));
            post.setAuthor(resultSet.getString(2));
            post.setTitle(resultSet.getString(3));
            post.setDate(resultSet.getString(4));
            post.setContent(resultSet.getString(5));

            posts.add(post);
        }

        return posts;
    }
    // 指定した掲示物番号の掲示物をリターン
    public Post postSelect(String postNumber) throws SQLException {
        Post post = new Post();

        String sql = "SELECT postnumber, author, pw, title, TO_CHAR(writtendate, 'yyyy-mm-dd hh24:mi'), content, " +
                "tag FROM postlist where postnumber="+postNumber;

        ResultSet resultSet = connection.createStatement().executeQuery(sql);

        while (resultSet.next()) {
            post.setPostNumber(resultSet.getString(1));
            post.setAuthor(resultSet.getString(2));
            post.setPw(resultSet.getString(3));
            post.setTitle(resultSet.getString(4));
            post.setDate(resultSet.getString(5));
            post.setContent(resultSet.getString(6));
            post.setTags(resultSet.getString(7));
        }

        return post;
    }
    // 掲示物の数をリターン
    public int howManyPosts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM postlist";

        ResultSet resultSet = connection.createStatement().executeQuery(sql);

        resultSet.next();

        return resultSet.getInt(1);
    }
    // タグがない場合
    public void postInsert(String author, String pw, String title, String content) throws SQLException {
        String sql = "INSERT INTO postlist(postnumber, author, pw, title, writtendate, content) " +
                "values (postnumseq.nextval, '"+author+"', '"+pw+"', '"+title+"', SYSDATE, '"+content+"')";

        connection.createStatement().executeUpdate(sql);
    }
    // タグがある場合
    public void postInsert(String author, String pw, String title, String content, String tags) throws SQLException {
        Statement statement = connection.createStatement();

        String postSql = "INSERT INTO postlist(postnumber, author, pw, title, writtendate, content, tag) " +
                "values (postnumseq.nextval, '"+author+"', '"+pw+"', '"+title
                +"', SYSDATE, '"+content+"', '"+tags+"')";

        statement.executeUpdate(postSql);

        HashSet<String> tagList = StringFormatter.tagsFix(tags);

        //タグ表に全てのタグをインサートする
        for(String tag:tagList) {
            String tagSql = "INSERT INTO tag(tagname, postnumber) " +
                    "values ('"+tag+"', postnumseq.currval)";

            statement.executeUpdate(tagSql);
        }
    }
    // 掲示物削除
    public void postDelete(String postNumber) throws SQLException {
        String sql = "DELETE postlist where postnumber="+postNumber;

        connection.createStatement().executeUpdate(sql);
    }
    // 掲示物編集
    public void postUpdate(String postNumber, String content) throws SQLException {
        String sql = "UPDATE postlist SET content='"+content+"' where postnumber="+postNumber;

        connection.createStatement().executeUpdate(sql);
    }


    /* --コメント-- */
    // 指定した掲示物のコメントリストを作成日にソートしてリターン
    public ArrayList<Reply> allCommentsSelect(String postNumber) throws SQLException {
        ArrayList<Reply> comments = new ArrayList<Reply>();

        String sql = "SELECT postnumber, author, TO_CHAR(writtendate, 'yyyy-mm-dd hh24:mi'), content, replynumber "+
            "FROM replylist WHERE postnumber="+postNumber+" ORDER BY writtendate";

        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        while (resultSet.next()) {
            Reply reply = new Reply();

            reply.setPostNumber(resultSet.getString(1));
            reply.setAuthor(resultSet.getString(2));
            reply.setDate(resultSet.getString(3));
            reply.setContent(resultSet.getString(4));
            reply.setReplyNumber(resultSet.getString(5));

            comments.add(reply);
        }

        return comments;
    }
    // 指定したコメントのパスワードをリターン
    public String commentPwSelect(String replyNumber) throws SQLException {
        String sql = "SELECT pw FROM replylist where replynumber="+replyNumber;

        ResultSet resultSet = connection.createStatement().executeQuery(sql);

        resultSet.next();

        return resultSet.getString(1);
    }
    // コメントをインサート
    public void commentInsert(String postNumber, String author, String pw, String content) throws SQLException {
        String sql = "INSERT INTO replylist(replynumber, postnumber, author, pw, writtendate, content) " +
                "values (REPLYNUMSEQ.nextval, '"+postNumber+"', '"+author+
                "', '"+pw+"', SYSDATE, '"+content+"')";

        connection.createStatement().executeUpdate(sql);
    }
    // コメントをデリート
    public void commentDelete(String replyNumber) throws SQLException {
        String sql = "DELETE replylist WHERE replynumber="+replyNumber;

        connection.createStatement().executeUpdate(sql);
    }


    /* --タグ-- */
    // 同じタグを持っている掲示物の[postnumber]をリスト型にリターン
    public ArrayList<String> tagSelect(String tagName) throws SQLException {
        String sql = "SELECT postnumber FROM tag WHERE tagname like '%"+tagName+"%'";

        ResultSet resultSet = connection.createStatement().executeQuery(sql);

        ArrayList<String> postNumberList = new ArrayList<String>();

        while (resultSet.next()) {
            postNumberList.add(resultSet.getString(1));
        }

        return postNumberList;
    }
}
