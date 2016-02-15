# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
  # Remove NSFW hiding.
  $('.nsfw').one('click', (ev) ->
    ev.preventDefault()
    parent = $(ev.target).closest('.nsfw')
    $('p.nsfw_text', parent).remove()
    $(parent).removeClass('nsfw')
  )
