window.App ||= {}

App.init = ->
  # Enable bootstrap tooltip
  $("a, span, i, div").tooltip()

  # Enable bootstrap select picker
  $('.selectpicker').selectpicker()

$(document).on "turbolinks:load", ->
  App.init()