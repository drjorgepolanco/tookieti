$(document).on 'page:load', ->
  $(".open-options").on 'click', (event) ->
    event.preventDefault()
    $(".options").slideToggle()