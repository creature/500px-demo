# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.like').on("ajax:beforeSend", (ev) -> # Hide all the love links, and show the spinner instead when clicking a like button.
    photo_id = $(ev.target).parents(".photo").data('photo-id')
    $(ev.target).addClass("hidden")
    $("#spinner_#{photo_id}").removeClass("hidden")
  )

  # Remove NSFW hiding.
  $('.nsfw').one('click', (ev) ->
    ev.preventDefault()
    parent = $(ev.target).closest('.nsfw')
    $('p.nsfw_text', parent).remove()
    $(parent).removeClass('nsfw')
  )
