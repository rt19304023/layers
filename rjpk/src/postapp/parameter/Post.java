package postapp.parameter;

public class Post {
    private String postNumber;  //掲示物番号
    private String author;      //作成者
    private String pw;
    private String title;       //タイトル
    private String date;        //作成日
    private String content;     //内容
    private String tags;


    public String getTags() {
        return tags;
    }
    public void setTags(String tags) {
        this.tags = tags;
    }
    public String getPw() {
        return pw;
    }
    public void setPw(String pw) {
        this.pw = pw;
    }
    public String getPostNumber() {
        return postNumber;
    }
    public void setPostNumber(String postNumber) {
        this.postNumber = postNumber;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }
}
