class App.Themes extends Spine.Controller

  constructor: ->
    super

  events:
    'change select': 'edit'

  edit: (e) =>
    theme = @$('select').val()
    $.ajax(
      url: "/themes/#{theme}"
      content:{}
      type: 'PUT'
    ).done @onThemeChanged

  onThemeChanged: =>
    document.location = document.location
