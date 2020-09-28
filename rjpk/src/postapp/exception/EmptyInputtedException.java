package postapp.exception;

public class EmptyInputtedException extends EmptyException {
    public EmptyInputtedException() {
        super("データが入力されていません。");
    }
}
