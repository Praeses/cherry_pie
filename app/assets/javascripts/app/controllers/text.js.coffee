class App.Texts extends Spine.Controller

  constructor: ->
    super
    @name = @el.attr('id')

    field =
      key: @name
      value: $(@el).text().trim() || "(click to add text)"
    show_view = $(JST['templates/fields/show'](field))
    $(@el).html(show_view)

    #@setup_read_content @el

  events:
    'click .show': 'edit'
    'blur .edit': 'read'
    'keyup .edit': 'onType'

  onType: (e) => @read(e) if e.keyCode == 13

  read: (e) =>
    field =
      key: @name
      value: $(e.target).val() || "(click to add text)"
    show_view = $(JST['templates/fields/show'](field))
    try
      $(e.target).replaceWith(show_view)
      @model.fields[@name] = $(e.target).val()
      @model.save()

  edit: (e) =>
    field =
      key: @name
      value: @model.fields[@name]
    edit_view = $(JST['templates/fields/edit'](field))
    $(e.target).replaceWith(edit_view)
    edit_view.focus().val( edit_view.val() )


