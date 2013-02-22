class App.Pages extends Spine.Controller

  constructor: ->
    App.Page.bind "refresh", @render
    App.Page.fetch {id: App.page_id}
    super

  events:
    "click .add_page": 'onAddPage'

  onAddPage: =>
    link = $("<li><a>(New Page)</a></li>")
    $('.pages ul').append link
    return new App.Internal({el:link, model:@model, isNew:true })

  setup_read: (elm) =>
    return new App.Link({el:elm, model:@model }) if $(elm).hasClass('link')
    return new App.Internal({el:elm, model:@model }) if $(elm).hasClass('page')
    return new App.Texts({el:elm, model:@model })


  render: (p) =>
    @model = App.Page.first()
    $('.read').addClass('editable')
    @setup_read(elm) for elm in $('.read')
    $('.pages').before("<button class='add_page'>Add Page</button>")
    @


