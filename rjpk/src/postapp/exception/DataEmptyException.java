package postapp.exception;

public class DataEmptyException extends EmptyException {
    public DataEmptyException() {
        super("受け取ったデータがありません。");
    }
}
