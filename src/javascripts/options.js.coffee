ghost = (isDeactivated) ->
  options.style.color = (if isDeactivated then "graytext" else "black")

  # The label color.
  options.frequency.disabled = isDeactivated # The control manipulability.
window.addEventListener "load", ->

  # Initialize the option controls.
  options.isActivated.checked = JSON.parse(localStorage.isActivated)

  # The display activation.
  options.frequency.value = localStorage.frequency

  # The display frequency, in minutes.
  options.blog_url.value = localStorage.blog_url
  ghost true  unless options.isActivated.checked

  # Set the display activation and frequency.
  options.isActivated.onchange = ->
    localStorage.isActivated = options.isActivated.checked
    ghost not options.isActivated.checked

  options.frequency.onchange = ->
    localStorage.frequency = options.frequency.value

  options.blog_url.onchange = ->
    localStorage.blog_url = options.blog_url.value
