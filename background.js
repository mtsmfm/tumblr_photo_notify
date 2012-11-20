function get_img_url() {
  var blog_url = localStorage.blog_url;
  var key = 'Ruo6uY2gkqOodhPr3xgjvGqRCIMaLlkVWP7BDXgMdXw7zsLJ8K';
  var url = "http://api.tumblr.com/v2/blog/" + blog_url + "/posts/photo?api_key=" + key;
  var img_url;
  $.ajax({
    url: url,
    success: function(data) {
      console.log(data);
      console.log(data.response.total_posts);
      var total_num = data.response.total_posts;
      var offset = Math.floor(total_num * Math.random());
      $.ajax({
        url: url + "&" + "offset=" + offset + "&limit=1" ,
        success: function(data){
          console.log(data);
          img_url = data.response.posts[0].photos[0].alt_sizes[3].url;
        },
        async: false
      });
    },
    async:   false
  });
  return img_url;
}
function show() {
  var time = /(..)(:..)/.exec(new Date());     // The prettyprinted time.
  var hour = time[1] % 12 || 12;               // The prettyprinted hour.
  var period = time[1] < 12 ? 'a.m.' : 'p.m.'; // The period of the day.
  var img_url = get_img_url();
  console.log(img_url);
  var notification = window.webkitNotifications.createHTMLNotification(
      'test.html' + '#' + img_url
      );
  notification.ondisplay = function(){
    // 表示されてから自動で閉じる
    setTimeout(function(){
      notification.cancel();
    },9000);
  };
  var img = new Image();
  img.src = img_url;
  img.onload = function(){
    notification.show();
  }
}

// Conditionally initialize the options.
if (!localStorage.isInitialized) {
  localStorage.isActivated = true;   // The display activation.
  localStorage.frequency = 60;        // The display frequency, in seconds.
  localStorage.blog_url = 'mogumogu-menma.tumblr.com';
  localStorage.isInitialized = true; // The option initialization.
}

// Test for notification support.
if (window.webkitNotifications) {
  // While activated, show notifications at the display frequency.
  if (JSON.parse(localStorage.isActivated)) { show(); }

  var interval = 0; // The display interval, in minutes.

  setInterval(function() {
    interval++;

    if (
      JSON.parse(localStorage.isActivated) &&
        localStorage.frequency <= interval
    ) {
      show();
      interval = 0;
    }
  }, 1000);
}
