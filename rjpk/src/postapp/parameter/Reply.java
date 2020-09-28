package postapp.parameter;

public class Reply {
    private String replyNumber;
    private String postNumber;
    private String author;
    private System pw;
    private String date;
    private String content;

    public void setReplyNumber(String replynumber) {
        this.replyNumber = replynumber;
    }
    public String getReplyNumber() {
        return replyNumber;
    }
    public void setPostNumber(String postnumber) {
        this.postNumber = postnumber;
    }
    public String getPostNumber() {
        return postNumber;
    }
    public void setAuthor(String author) {
        this.author = author;
    }
    public String getAuthor() {
        return author;
    }
    public void setPw(System pw) {
        this.pw = pw;
    }
    public System getPw() {
        return pw;
    }
    public void setDate(String date) {
        this.date = date;
    }
    public String getDate() {
        return date;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getContent() {
        return content;
    }
}
