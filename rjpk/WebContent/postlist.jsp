<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>

<!DOCTYPE html>

<html>
<head>
  <title>トピック一覧</title>

  <link rel="stylesheet" type="text/css" href="css/sample.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
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

    #write-open-btn {
      position: fixed;
      bottom: 8em;
      right: 0.02em;
      height: 5em;
      width: 5em;
      border-radius: 100%;
      padding: 1em;
      margin: 2em;
      background-color: #82be28;
      transition-property: background-color;
      transition-duration: 0.3s;
      transition-timing-function: ease;
      transition-delay: 0s;
    }

    #write-open-btn:hover {
      background-color: #507d1f;
    }

    #write-close-btn {
      color: black;
    }

    #write-close-btn:hover {
      color: #82be28;
      text-decoration: none;
    }

    #top-btn {
      position: fixed;
      bottom: 1.9em;
      right: 0.02em;
      height: 5em;
      width: 5em;
      border-radius: 100%;
      margin: 2em;
      background-color: #82be28;
      transition-property: background-color;
      transition-duration: 0.3s;
      transition-timing-function: ease;
      transition-delay: 0s;
    }

    #top-btn:hover {
      background-color: #507d1f;
    }

    .apen {
      font-size: 2.5em;
    }

    .post-out-box {
      transition-property: color;
      transition-duration: 0.4s;
      transition-timing-function: ease;
      transition-delay: 0s;
    }

    .post-out-box:hover {
      color: #82be28;
    }

    #load-btn {
      transition-property: color;
      transition-duration: 0.4s;
      transition-timing-function: ease;
      transition-delay: 0s;
    }
    #load-btn:hover {
      color: #82be28;
    }
  </style>
</head>

<body id="pagetop">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="js/get-more-posts.js"></script>
<script>
    $(function () {
        $("#write-open-btn").click(
            function () {
                $("#toggling").css("display", "");

                var offset = $("#toggling").offset();

                $("html, body").animate({scrollTop: offset.top}, "slow");
            }
        );

        $("#write-close-btn").click(
            function () {
                $("#toggling").css("display", "none");
            }
        );

        $("#top-btn").click(
            function () {
                $("html, body").animate({scrollTop: 0}, "slow");
            }
        );
    });
</script>


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
<br><br>
<header class="l-pageHeader">
  <h1 class="l-pageHeader_title">バナナ掲示板</h1>
</header>

<div class="m-container m-pageBodyInner">

  <div id="write-open-btn" style="cursor: pointer;" title="トピック作成">
    <div style="width: 100%; height: 100%; display: table;">
      <p style="width: 100%; height: 100%; text-align: center; display: table-cell; vertical-align: middle;">
        <i class="material-icons apen" style="color: white;">create</i></p>
    </div>
  </div>

  <div id="top-btn" style="cursor: pointer;" title="ページのTOPへ">
    <div style="width: 100%; height: 100%; display: table;">
      <p style="width: 100%; height: 100%; text-align: center; display: table-cell; vertical-align: middle;">
        <i class="material-icons " style="color: white; font-size: 2.5em;">arrow_upward</i>
      </p>
    </div>
  </div>




  <div id="post-out" class="m-roundBox m-roundBox-min-md">
    <h2 class="m-section_heading m-section_heading-h2">トピック一覧</h2>
    <br>
  </div>

  <div id="load-btn" onclick="getMorePosts()"
      style="width: 100%;margin-top: 2em;padding: 2em;text-align: center;">
    <p style="font-size: 2em;">
      もっと見る
    </p>
  </div>

  <div id="toggling" style="display: none;">
    <div class="m-roundBox m-roundBox-min-md" style="margin-top: 5em;">
      <main class="l-main" id="main">
        <section class="m-section">

          <div title="post-write">  <%-- 新しいトピック作成 --%>
            <h2 class="m-section_heading m-section_heading-h2" style="width: 100%">トピック作成<a style="float: right"
                                                                                            id="write-close-btn">X</a>
            </h2>
            <br>
            <form name="myform" method="post" onSubmit="return checkSubmit()" method="post" action="PostWriteServlet">
              <input name="title" type="text" maxlength="60" required placeholder="トピックタイトル" style="width: 100%;">
              <br><br>
              作成者 : <input name="author" type="text" maxlength="30">
              パスワード : <input name="pw" style="font-family:Verdana" type="password" maxlength="28" required>
              <br><br>
              内容<br>
              <textarea name="content" cols="70" rows="3" maxlength="2000" required class="m-roundBorder"style="margin-top: 0;"></textarea>
              タグ<textarea name="tags" cols="70" rows="2" maxlength="255" class="m-roundBorder" style="margin-top: 0;"></textarea>
            <strong><p>※複数タグをつける場合は、「 / (スラッシュ) 」で区切ってください</p></strong>
              <div class="m-btnGroup">
                <p class="m-btnGroup_item"><input type="submit" class="m-btn" value="作成"></p>
              </div>
            </form>

            <script type="text/javascript">
                function checkSubmit() {
                    result = confirm("作成しても良いですか？");
                    if (result) {
                        document.myform.action = "PostWriteServlet";
                    } else {
                        alert("キャンセルします。");
                        return false;
                    }
                }
            </script>
          </div>
        </section>
      </main>
    </div>
  </div>
</div>
<br><br>
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
