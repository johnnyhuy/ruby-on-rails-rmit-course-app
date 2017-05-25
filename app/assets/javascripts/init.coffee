window.App ||= {}

App.init = ->
  # Enable bootstrap tooltip
  $("a, span, i, div").tooltip()

  # Enable bootstrap select picker
  $('.selectpicker').selectpicker()

  $('#location').mask("999.99.999")

$(document).on "turbolinks:load", ->
  App.init()