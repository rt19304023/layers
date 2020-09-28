<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="postapp.parameter.Post" %>
<%@ page import="postapp.DataBaseAccess" %>
<%@ page import="postapp.StringFormatter" %>
<%@ page import="postapp.parameter.Reply" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>
<%@ page pageEncoding="utf-8"
         contentType="text/html;charset=utf-8" %>


<%--  /*String postNumber = request.getParameter("postnumber");
  boolean isEdit = request.getParameter("isedit").equals("true");

  Post post = new Post();
  ArrayList<Reply> comments = new ArrayList<Reply>();
  try {
	  DataBaseAccess access = (DataBaseAccess)property.CreateDataBaseInstance.getInstance("Oracle");
    post = access.postSelect(postNumber);
    comments = access.allCommentsSelect(postNumber);
    access.disconnect();
  } catch (Exception e) {
    e.printStackTrace();
  }

  String title = post.getTitle();
  String author = post.getAuthor();
  String date = post.getDate();
  String content = post.getContent();
  String htmlContent = StringFormatter.htmlLineFormat(post.getContent());
  HashSet<String> tags = null;

  boolean hasTag = true;
  if (post.getTags() == null) {
    hasTag = false;
  } else {
    tags = StringFormatter.tagsFix(post.getTags());
  }

  boolean hasComment = true;

  if (comments.size() < 1) {
    hasComment = false;
  }*/--%>


<!DOCTYPE html>

<html>
<head>
  <title>トピック</title>

  <link rel="stylesheet" type="text/css" href="css/sample.css">
      <link rel="stylesheet" type="text/css" href="css/color.css">

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
      height: 3em;
      transition-property: background-color;
      transition-duration: 0.4s;
      transition-timing-function: ease;
      transition-delay: 0s;
    }

    input[type=submit]:hover {
      background-color: #527819;
    }

    input[type=text], input[type=password] {
      border: 2px solid #f0f0ee;
      border-radius: 20px;
      padding: 0.5em 1em;
      outline: none;
    }
  </style>
</head>

<body>

  <header class="l-header" id="header">
    <div class="l-header_bar">
      <div class="l-header_function">
        <div class="l-header_nav">
          <ul class="l-header_nav_items">
            <li class="l-header_nav_item"><a href="index">トップ</a></li>
            <li class="l-header_nav_item"><a href="postlist">トピック一覧</a></li>
            <li class="l-header_nav_item">
              <form id="form1" action="TagSearchServlet">
                <input id="sbox" name="search" type="text" placeholder="タグ検索"/>
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
    <main class="l-main" id="main">

        <div title="topic-upper"> <%-- トピックの上段部 --%>
          <h2 class="m-section_heading m-section_heading-h2">${post.title}</h2><br>
          <h4>Author : ${post.author} &nbsp;&nbsp; 作成日 : ${post.date}
          </h4>
          <h4>タグ :
            <c:choose>
              <c:when test="${hasTag}">
                ${tags}
              </c:when>
              <c:otherwise>
                タグがありません。
              </c:otherwise>
            </c:choose>
          </h4>
        </div>

        <%--
        [タイトル]
        作成者 : [作成者名] 作成日 : [作成日]
        --%>
        <br>
        <h4>内容</h4>
        <form name="myform" method="post">
          <div title="topic-content"> <%-- トピックの内容 --%>
            <c:choose>
              <c:when test="${isEdit}">
                <textarea name="content" cols="70" rows="10" maxlength="3998" required
                          class="m-roundBorder">${post.content}</textarea>
              </c:when>
              <c:otherwise>
                <p class="m-roundBorder" style="padding: 1em;">${htmlContent}
                </p>
              </c:otherwise>
            </c:choose>
          </div>
          <%--
          // 編集モードの場合
          内容
          {      内容入力      }
          // 一般の場合
          内容
          [      内容表示      ]
          --%>
          <br><br>
          <div title="topic-under"><%-- トピックの下段部 --%>
            <form action="PostEditJudge" method="post" >
            <input type="hidden" name="postnumber" value="${postNumber}">
            <c:choose>
              <c:when test="${isEdit}">
                <input type="submit" value="編集" onclick="form.action='PostEditServlet'"
                       style="width: 5em;">
              </c:when>
              <c:otherwise>
                <input type="password" style="font-family:Verdana" name="pw" required placeholder="パスワード">
                <input type="submit" value="トピック削除" onclick="checkSubmit()"
                       style="width: 8em;">
                <input type="submit" value="トピック編集" onclick="form.action='PostEditJudge'"
                       style="width: 8em;">
              </c:otherwise>
            </c:choose>
            </form>
			  <script type="text/javascript">
                  function checkSubmit() {
         	          result = confirm("本当に削除しますか？");
                    if(result){
                      document.myform.action = "PostDeleteServlet";
                    }else{
						alert("キャンセルします。");
            return false;
					}
                  }
                </script>
          </div>
          <%--
          // 掲示物編集モードの場合
            {編集送信ボタン}

          // 一般の情報
            パスワード : {パスワード入力} {削除ボタン} {編集ボタン}
          --%>
			  </form>
  </div>




  <%--
  コメント
  {     コメント入力      }
  名前 : {名前入力} パスワード : {パスワード入力} {コメント送信ボタン}
  --%>


  <c:choose>
    <c:when test="${!isEdit}">



  <div class="m-roundBox m-roundBox-min-md"style="margin-top: 5em;">

    <h2 class="m-section_heading m-section_heading-h2" >コメント</h2>


    <div title="comment-out">
      <c:choose>
        <c:when test="${hasComment}">
          <c:forEach var="comment" items="${comments}"> <%-- コメント出力部 --%>


            <br>

            <div title="comment-print">
              作成者 : <c:out value="${comment.author}"/> 作成日 : <c:out value="${comment.date}"/> <br>
              <%
                Reply buff = (Reply) pageContext.getAttribute("comment");
                String commentContent = StringFormatter.htmlLineFormat(buff.getContent());
              %>

              <%=commentContent%>
            </div>

            <br>

            <div title="comment-delete" >

              <form name="comeform"method="post"onsubmit="return checkSubmit2()">
                <input type="hidden" name="replynumber" value="${comment.replyNumber}">
                <input type="hidden" name="postnumber" value="${comment.postNumber}">
                <input type="password" style="font-family:Verdana" name="pw" maxlength="28" required placeholder="パスワード" >

                <input type="submit" value="削除" style="width: 5em;">

              </form>
				<script type="text/javascript">
                  function checkSubmit2() {
         	          result = confirm("本当に削除しますか？");
                    if(result){
                      document.comeform.action = "CommentDeleteServlet";
                    }else{
						alert("キャンセルします。");
            return false;

					}
                  }
                </script>
            </div>
            <br>
              <hr class="h">
          </c:forEach>
        </c:when>
        <c:otherwise>
          コメントがありません。
        </c:otherwise>
      </c:choose>
    </div>
  </div>
  <%--
  <hr>
  作成者 : [作成者名] 作成日 : [作成日] <br>
  [    コメント    ]<br>
  {パスワード入力} {削除ボタン}<br>

  上がコメントの数どおり繰り返す
  --%>
    </c:when>
  </c:choose>

	  <c:choose>
    <c:when test="${ !isEdit}">
      <div title="comment-write"> <%-- コメント入力部 --%>
        <div class="m-roundBox m-roundBox-min-md"style="margin-top: 5em;">
          <form method="post" action="CommentWriteServlet">
            <input type="hidden" name="postnumber" value="${postNumber}">

            <h2 class="m-section_heading m-section_heading-h2">コメント入力</h2>
            <br>

              <textarea name="content" cols="80" rows="5" maxlength="1998" required placeholder="コメント"
                        class="m-roundBorder"></textarea><br>
            <input type="text" name="author" maxlength="58" placeholder="名前">
            <input type="password" style="font-family:Verdana" name="pw" maxlength="28" required placeholder="パスワード">
            <input type="submit" value="作成"
                   style="width: 5em;">
          </form>
        </div>
      </div>
    </c:when>
  </c:choose>
</div>
<br><br>
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
