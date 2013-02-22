class App.Pages extends Spine.Controller

  constructor: ->
    App.Page.bind "refresh", @render
    App.Page.fetch {id: App.page_id}
    super

  setup_read: (elm) =>
    return new App.Link({el:elm, model:@model }) if $(elm).hasClass('link')
    return new App.Internal({el:elm, model:@model }) if $(elm).hasClass('page')
    return new App.Texts({el:elm, model:@model })

  render: (p) =>
    @model = App.Page.first()
    $('.read').addClass('editable')
    @setup_read(elm) for elm in $('.read')
    @


