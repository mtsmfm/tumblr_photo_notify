get_img_url = ->
  blog_url = localStorage.blog_url
  key = "Ruo6uY2gkqOodhPr3xgjvGqRCIMaLlkVWP7BDXgMdXw7zsLJ8K"
  url = "http://api.tumblr.com/v2/blog/" + blog_url + "/posts/photo?api_key=" + key
  img_url = undefined
  $.ajax
    url: url
    success: (data) ->
      console.log data
      console.log data.response.total_posts
      total_num = data.response.total_posts
      offset = Math.floor(total_num * Math.random())
      $.ajax
        url: url + "&" + "offset=" + offset + "&limit=1"
        success: (data) ->
          console.log data
          img_url = data.response.posts[0].photos[0].alt_sizes[3].url

        async: false


    async: false

  img_url
show = ->
  time = /(..)(:..)/.exec(new Date()) # The prettyprinted time.
  hour = time[1] % 12 or 12 # The prettyprinted hour.
  period = (if time[1] < 12 then "a.m." else "p.m.") # The period of the day.
  img_url = get_img_url()
  console.log img_url
  notification = window.webkitNotifications.createHTMLNotification("notification.html" + "#" + img_url)
  notification.ondisplay = ->
    
    # 表示されてから自動で閉じる
    setTimeout (->
      notification.cancel()
    ), 9000

  img = new Image()
  img.src = img_url
  img.onload = ->
    notification.show()

# Conditionally initialize the options.
unless localStorage.isInitialized
  localStorage.isActivated = true # The display activation.
  localStorage.frequency = 60 # The display frequency, in seconds.
  localStorage.blog_url = "mogumogu-menma.tumblr.com"
  localStorage.isInitialized = true # The option initialization.

# Test for notification support.
if window.webkitNotifications
  # While activated, show notifications at the display frequency.
  show()  if JSON.parse(localStorage.isActivated)
  interval = 0 # The display interval, in minutes.
  setInterval (->
    interval++
    if JSON.parse(localStorage.isActivated) and localStorage.frequency <= interval
      show()
      interval = 0
  ), 1000
