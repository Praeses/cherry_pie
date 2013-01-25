class App.Pages extends Spine.Controller

  constructor: ->
    App.Page.bind "refresh", @render
    App.Page.fetch {id: App.page_id}
    super

  events:
    'click .show': 'edit'
    'blur .edit': 'read'
    'keyup .edit': 'onType'

  onType: (e) => @read(e) if e.keyCode == 13

  read: (e) =>
    name = $(e.target).attr('name')
    field =
      key: name
      value: $(e.target).val() || "(click to add text)"
    show_view = $(JST['templates/fields/show'](field))
    try
      $(e.target).replaceWith(show_view)
      @model.fields[name] = $(e.target).val()
      @model.save()


  edit: (e) =>
    name = $(e.target).attr('name')
    field =
      key: name
      value: @model.fields[name]
    edit_view = $(JST['templates/fields/edit'](field))
    $(e.target).replaceWith(edit_view)
    edit_view.focus().val( edit_view.val() )

  setup_read: (elm) =>
    name = elm.id
    field =
      key: name
      value: $(elm).text() || "(click to add text)"
    show_view = $(JST['templates/fields/show'](field))
    $(elm).html(show_view)


  render: (p) =>
    @model = App.Page.first()
    $('.read').addClass('editable')
    @setup_read(elm) for elm in $('.read')
    @


