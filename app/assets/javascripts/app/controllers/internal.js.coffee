class App.Internal extends Spine.Controller

  constructor: ->
    super
    @a = $('a', @el)
    if @isNew
      @page = new App.Page({})
    else
      id = parseInt @a.attr('data-id')
      href = @a.attr('href')
      name = @a.text().trim()
      @page = new App.Page({ name: name, href: href })
      @page.id = id

    @page.bind 'ajaxSuccess', @afterSave

    editer_view = $(JST['templates/fields/editinternal']( @page ))
    $(@el).append editer_view

  events:
    'change input': 'onChange'

  onChange: (e) =>
    @page.name = $(e.target).val().trim() || null
    @a.text( @page.name )
    @page.save()

  afterSave: (status, page) =>
    @a.attr('href', page.href)


