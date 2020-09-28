function initPostOut(postNumber, title, author, date, content) {
    var outsideBox = $('<div />');
    var postOutBox = $('<div />', {
        class: 'post-out-box',
        click: function(){
            location.href='PostSelectServlet?postnumber='+postNumber+'&isedit=false'
        },
        css: {
            cursor: 'pointer'
        }
    });
    var titleOut = $('<h3 />', {
        text: title
    });
    var infoOut = $('<p />', {
        html: '作成者 : '+author+'&nbsp&nbsp&nbsp&nbsp作成日 : '+date
    });
    var contentOut = $('<p />', {
        html: content
    });
    var br = $('<br />');
    var hr = $('<hr />', {class: 'h'});

    postOutBox.append(br);
    postOutBox.append(titleOut);
    postOutBox.append(infoOut);
    postOutBox.append(contentOut);

    outsideBox.append(br);
    outsideBox.append(postOutBox);
    outsideBox.append(br);
    outsideBox.append(hr);

    return outsideBox;
}

function postAdd(data, postarr) {
    var postNumber = data.posts[postarr].postnumber;
    var title = data.posts[postarr].title;
    var author = data.posts[postarr].author;
    var date = data.posts[postarr].date;
    var content = data.posts[postarr].content.replace(/\n/gi, '<br>');

    return initPostOut(postNumber, title, author, date, content);
}

function noMorePost() {
    var nmp = $('<div />', {
        class: 'no-more-post',
        css: {
            width: '100%',
            marginTop: '2em',
            padding: '2em',
            textAlign: 'center'
        }
    });

    var p = $('<p />', {
        css: {
            fontSize: '2em'
        },
        text: 'もうトピックがありません。'
    });

    nmp.append(p);

    return nmp;
}

var lastPrintedPost = 0;
var showingPost = 5;
var animatedPage = 0;
function getMorePosts() {
    $.ajax({
        url: "GetMorePosts",
        type: "post",
        cache: "false",
        dataType: "json",
        data: {
            "lastestpost": lastPrintedPost,
            "showingposts": showingPost
        },
        success: function (data) {
            if(data.hasData==true) {
                lastPrintedPost += showingPost;

                for (var i in data.posts) {
                    var buff = postAdd(data,  i);
                    buff.addClass('page'+animatedPage);
                    buff.hide();

                    $('#post-out').append(buff);
                }

                $('.page'+animatedPage).slideDown();
                animatedPage++;
            } else {
                $('#load-btn').fadeOut('fast', function () {
                    var nmp = noMorePost().hide();
                    $(this).replaceWith(nmp);
                    $('.no-more-post').fadeIn('fast');
                });
            }
        },
        error: function () {
            alert('ERROR');
        }
    });
}

$(function () {
    getMorePosts();
});
