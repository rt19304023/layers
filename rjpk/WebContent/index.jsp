<%@ page import="postapp.parameter.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="postlist.TitleAbridgement" %>
<%@ page import="postapp.StringFormatter" %>
<%@ page pageEncoding="utf-8"
         contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	ArrayList<Post> postBuff = new ArrayList<Post>();
	TitleAbridgement title = new TitleAbridgement();

	postBuff = title.abridgement();

	ArrayList<Post> post = new ArrayList<Post>();

	  for(Post buff : postBuff) {
		  if(buff.getTitle().length()>15) {
	          buff.setTitle(buff.getTitle().substring(0, 14)+"...");
	      }
	      if(buff.getContent().length()>26) {
	          buff.setContent(buff.getContent().substring(0, 25)+"...");
	      }
	      post.add(buff);
	  }
  /*ArrayList<Post> post1 = new ArrayList<Post>();
  for(Post buff : postBuff) {
      if(buff.getTitle().length()>15) {
          buff.setTitle(buff.getTitle().substring(0, 14)+"...");
      }
      post1.add(buff);
  }*/
%>

<!DOCTYPE html>

<html>
  <head>
    <title>ホーム</title>

    <link rel="stylesheet" type="text/css" href="css/sample.css">
    <link rel="stylesheet" type="text/css" href="css/color.css">
    <link rel="stylesheet" type="text/css" href="css/list.css">
    <style type="text/css">
      textarea {
        border: none;
        outline: none;
        resize: none;
        width: 100%;
      }
      textarea::-webkit-scrollbar {
        border-radius: 10px;
        width: 2em;
      }
      textarea::-webkit-scrollbar-thumb {
        border-radius: 30px;
        background-color: #82be28;
        background-clip: padding-box;
        border: 0.75em solid transparent;
      }
      textarea::-webkit-scrollbar-track {
        display: none;
      }

      input[type=submit] {
        border: none;
        background: #82be28;
        color: white;
        text-shadow: none;
        border-radius: 20px;

        transition-property: background;
        transition-duration: 0.4s;
        transition-timing-function: ease;
        transition-delay: 0s;
      }
      input[type=submit]:hover {
        background: #527819;
      }

      input[type=text], input[type=password] {
        border: 2px solid #f0f0ee;
        border-radius: 20px;
        padding: 0.5em 1em;
        outline: none;
      }
      #post-out {
        transition-property: color, background-color;
        transition-duration: 0.4s;
        transition-timing-function: ease;
        transition-delay: 0s;
      }

      #post-out:hover {
        color: #82be28;
        background-color: lightgray;
      }
    </style>
  </head>

  <!-- エクリプステスト小島 -->

  <body>
    <header class="l-header" id="header">
      <div class="l-header_bar">
        <div class="l-header_function">
          <div class="l-header_nav">
            <ul class="l-header_nav_items">
              <li class="l-header_nav_item"><h2><a href="index">トップ</a></h2></li>
              <li class="l-header_nav_item"><h2><a href="postlist">トピック一覧</a></h2></li>
              <li class="l-header_nav_item">
                <form id="form1" class="form" action="TagSearchServlet" method="get">
                  <input id="sbox" id="s" name="search" maxlength="28" type="text" placeholder="タグ検索" required>
                  <input id="sbtn" type="submit" value="検索" style="height: 2.7em;width: 6em;"/>
                </form>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </header>

    <br><br>
    <header class="l-pageHeader">
    <h1 class="l-pageHeader_title">バナナ掲示板</h1>
    </header>


  <div class="m-container m-pageBodyInner">
    <div class="m-roundBox m-roundBox-min-md">
        <main>
          <div title="new-posts"> <%-- 最新のトピック --%>
            <h2 class="m-section_heading m-section_heading-h2">最新トピック</h2>

            <ul class="Sub">
                <li class="Title">タイトル</li>
                <li class="Content">内容</li>
                <li class="User"><p>作者</p><p>日付</p></li>
            </ul><hr class="hr">

              <c:forEach var="post" items="<%=post%>">
              <div id="post-out" onclick="location.href='PostSelectServlet?postnumber=${post.postNumber}&isedit=false'"
    style="cursor: pointer;">
              <ul class="List">
                  <li class="Title"><c:out value="${post.title}" /></li>
                  <li class="Content"><c:out value="${post.content}" /></li>
                  <li class="User">
                  <p><c:out value="${post.author}" /></p>
                  <p><c:out value="${StringFormatter.dateFormat(post.date, \"yyyy-MM-dd HH:mm\")}" /></p>
                  </li>
              </ul><hr class="h">
              </div>
              </c:forEach>
             <table>
              <%--
                  <tr><th>掲示物番号</th><th>作成者</th>
                  <th><a href="掲示物リンク">タイトル</a></th><th>掲示日</th></tr>
              --%>
            </table>
          </div>


            <ul class="l-header_nav_items">
              <li class="l-header_nav_item"><a href="postlist">トピック一覧へ</a></li>
            </ul>

        </main>

    </div>
  </div>
  <br><br><br><br><br><br>

  <footer class="l-footer">
    <div class="m-container">
      <div class="l-footer_function">
        <div class="l-footer_function_row l-footer_function_row-01">
        </div>
      </div>
    </div>
  </footer>
  </body>
</html>
