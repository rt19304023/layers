<%@ page pageEncoding="utf-8"
         contentType="text/html;charset=utf-8" %>

<!DOCTYPE html>

<html>
  <head>
    <title>パスワードが違います</title>
  </head>

  <link rel="stylesheet" type="text/css" href="css/sample.css">
      <link rel="stylesheet" type="text/css" href="css/color.css">
    <style type="text/css">
      input[type=submit] {
        border: none;
        background: #82be28;
        color: white;
        text-shadow: none;
        border-radius: 20px;
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
    </style>

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
                  <input id="sbox"  id="s" name="search" maxlength="28" type="text" placeholder="タグ検索" required>
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
      <body>
      <br><br>
        <main>
          <h2 class="m-section_heading m-section_heading-h2">権限がありません。</h2>
          <br>
        <h1>パスワードが違います。</h1>
        <br><br>
          <div class="l-header_nav">
            <ul class="l-header_nav_items">
              <li>　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</li>
              <li class="l-header_nav_item">
                <a href="postview?postnumber=${postnumber}&isedit=false">前の画面に戻る</a>
              </li>
            </ul>
          </div>
        </main>
        <br>
      </body>
    </div>
  </div>
    <br>
  <footer class="l-footer">
    <div class="m-container">
      <div class="l-footer_function">
          <div class="l-footer_function_row l-footer_function_row-01">
          </div>
      </div>
    </div>

  </footer>
</html>
