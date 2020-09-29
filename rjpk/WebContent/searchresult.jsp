<%--@ page import="postapp.DataBaseAccess" --%>
<%--@ page import="java.util.ArrayList" --%>
<%@ page import="postapp.parameter.Post" %>
<%@ page import="postapp.StringFormatter" %>
<%@ page pageEncoding="utf-8"
         contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  /*String tagName = request.getParameter("search");

  ArrayList<Post> searchedPost = new ArrayList<Post>();

  boolean isEmpty = false;
  try {
	  DataBaseAccess access = (DataBaseAccess)property.CreateDataBaseInstance.getInstance("Oracle");

    ArrayList<String> postNumberList =  access.tagSelect(tagName);

    for(String postNumber : postNumberList) {
        Post post = access.postSelect(postNumber);
        searchedPost.add(post);
    }
    if(searchedPost.size()<1) {
        isEmpty = true;
    }

    access.disconnect();
  } catch (Exception e) {
      e.printStackTrace();
  }*/
%>

<!DOCTYPE html>

<html>
  <head>
    <title>検索結果</title>
    <link rel="stylesheet" type="text/css" href="css/sample.css">
        <link rel="stylesheet" type="text/css" href="css/color.css">

    <style type="text/css">
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
        transition-property: color;
        transition-duration: 0.4s;
        transition-timing-function: ease;
        transition-delay: 0s;
      }

      #post-out:hover {
        color: #82be28;
      }
    </style>
  </head>

  <header class="l-pageHeader">
    <header class="l-header" id="header">
      <div class="l-header_bar">
        <div class="l-header_function">
          <div class="l-header_nav">
            <ul class="l-header_nav_items">
              <li class="l-header_nav_item"><a href="index">トップ</a></li>
              <li class="l-header_nav_item"><a href="postlist">トピック一覧</a></li>
              <li class="l-header_nav_item">
                <form id="form1" action="TagSearchServlet" method="get">
                  <input id="sbox" name="search" maxlength="28" type="text" placeholder="タグ検索" required>
                  <input id="sbtn" type="submit" value="検索" style="height: 2.7em;width: 6em;"/>
                </form>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </header>
    <br>
	     <header class="l-pageHeader">
        <h1 class="l-pageHeader_title">バナナ掲示板</h1>
    </header>
  </header>

  <div class="m-container m-pageBodyInner">
    <div class="m-roundBox m-roundBox-min-md">
      <h2 class="m-section_heading m-section_heading-h2">検索結果 : ${tagName}</h2>
      <body>

        <main>

          <br>



          <c:choose>
            <c:when test="${isEmpty}">
              <h4>一致するタグがありません。</h4>
              <br>
              <div class="l-header_nav">
                <ul class="l-header_nav_items">
                  <li>　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</li>
                  <li class="l-header_nav_item"><a href="index.jsp">トップに戻る</a>
                  </li>
                </ul>
              </div>
            </c:when>
            <c:otherwise>
              <c:forEach var="post" items="${searchedPost}">


                  <div id="post-out"  onclick="location.href='PostSelectServlet?postnumber=${post.postNumber}&isedit=false'"
        style="cursor: pointer;">
        <h4>
        <c:out value="${post.title}" />
      </h4>
                <p>作成者 : <c:out value="${post.author}" /> 作成日 : <c:out value="${post.date}" /></p>
                <br>
                <%
                  Post buff = (Post)pageContext.getAttribute("post");
                  String content = StringFormatter.htmlLineFormat(buff.getContent());
                %>
                <%=content%>

                  <hr class="h">
                  </div>
              </c:forEach>
            </c:otherwise>
          </c:choose>
          </div>
        </main>

      </body>
    </div>
  </div>
  <br><br><br><br><br>
  <footer class="l-footer">
    <div class="m-container">
      <div class="l-footer_function">
        <div class="l-footer_function_row l-footer_function_row-01">
        </div>
      </div>
    </div>
  </footer>
</html>
