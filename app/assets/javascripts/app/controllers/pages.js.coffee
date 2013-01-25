class App.Pages extends Spine.Controller

  constructor: ->
    App.Page.bind "refresh", @render
    App.Page.fetch {id: App.page_id}
    super

  events:
    'click .read': 'edit'
    'blur .edit': 'read'

  read: (e) =>
    name = $(e.target).attr('name')
    field =
      key: name
      value: $(e.target).val()
    show_view = $(JST['templates/fields/show'](field))
    $(e.target).replaceWith(show_view)
    @model.fields[name] = field.value
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
      value: $(elm).text()
    show_view = $(JST['templates/fields/show'](field))
    $(elm).html(show_view)


  render: (p) =>
    @model = App.Page.first()
    $("##{key}").addClass('editable') for key,value of @model.fields
    @setup_read(elm) for elm in $('.editable')
    @


