class App.Internal extends Spine.Controller

  constructor: ->
    super
    @a = $('a', @el)
    id = parseInt @a.attr('data-id')
    name = @a.text().trim()
    @page = new App.Page({ name: name })
    @page.id = id
    editer_view = $(JST['templates/fields/editinternal']( @page ))
    $(@el).append editer_view
    console.log @page

  events:
    'change input': 'onChange'

  onChange: (e) =>
    @page.name = $(e.target).val().trim() || null
    @a.text( @page.name )
    debugger
    @page.save()


