package postapp;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;

public class StringFormatter {
    // "yyyy-MM-dd HH:mm:ss" 形式の文字列を指定した形式に変換
    public static String dateFormat(String date, String format) throws ParseException {
        SimpleDateFormat originFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        SimpleDateFormat fixingFormat = new SimpleDateFormat(format);

        Date dateBuff = originFormat.parse(date);

        return fixingFormat.format(dateBuff);
    }

    // 文字列の改行をHTMLの<br>タグに変換
    public static String htmlLineFormat(String content) {
        return content.replace("\n", "<br>");
    }

    // 文字列のタグをスペースできって配列にリターン
    public static HashSet<String> tagsFix(String tags) {
        String[] tagListBuff = tags.split("/");

        HashSet tagSet = new HashSet<String>(Arrays.asList(tagListBuff));

        tagSet.remove("");

        return tagSet;
    }

    public static int howManyLines(String content) {
        int linenum = 0;
        for(int i=0;i<content.length();i++) {
            if('\n' == content.charAt(i)) {
                linenum++;
            }
        }
        return linenum;
    }

    public static String stringLineCut(int line, String content) {
        int linenum = 0;
        String buff = content;
        for(int i=0;i<content.length();i++) {
            if('\n' == content.charAt(i)) {
                linenum++;
            }
            if(linenum>=line) {
                buff = buff.substring(0, i);
                break;
            }
        }

        return buff;
    }

    public static String sqlEscape(String content){
      return content.replaceAll("'", "''").replaceAll("\"", "\\\"");
    }
}
