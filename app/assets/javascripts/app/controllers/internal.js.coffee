class App.Internal extends Spine.Controller

  constructor: ->
    super
    @a = $('a', @el)
    if @isNew
      @page = new App.Page({ canDestroy:true })
    else
      id = parseInt @a.attr('data-id')
      canDestroy = @a.attr('data-candestroy') is 'true'
      href = @a.attr('href')
      name = @a.text().trim()
      @page = new App.Page({ name: name, href: href, canDestroy: canDestroy  })
      @page.id = id

    @page.bind 'ajaxSuccess', @afterSave

    editer_view = $(JST['templates/fields/editinternal']( @page ))
    $(@el).append editer_view

  events:
    'change input': 'onChange'
    'click button': 'onDestroy'

  onDestroy: (e) =>
    $(@el).remove()
    @page.destroy()

  onChange: (e) =>
    @page.name = $(e.target).val().trim() || null
    @a.text( @page.name )
    @page.save()

  afterSave: (status, page) =>
    @a.attr('href', page.href)


