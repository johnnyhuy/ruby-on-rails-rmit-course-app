window.App ||= {}

App.init = ->
  # Enable bootstrap tooltip
  $("a, span, i, div").tooltip()

  # Enable bootstrap select picker
  $('.selectpicker').selectpicker()

  $('#location').mask("999.99.999")

  $("input[type=file]").change ->
    arr = this.value.split('\\')
    file = arr[2]
    $('.btn-file .caption').text(file)

$(document).on "turbolinks:load", ->
  App.init()