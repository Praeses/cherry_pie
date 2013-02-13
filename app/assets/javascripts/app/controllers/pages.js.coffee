class App.Pages extends Spine.Controller

  constructor: ->
    App.Page.bind "refresh", @render
    App.Page.fetch {id: App.page_id}
    super

  events:
    'click .show': 'edit'
    'blur .edit': 'read'
    'click .showlink': 'editlink'
    'click .editlink button#save': 'readlink'
    'click .editlink button#clear': 'clearlink'
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

  editlink: (e) =>
    name = $(e.target).attr('name')
    field =
      key: name
      value: @model.fields[name]
      href: @model.fields[name + '_href']
    edit_view = $(JST['templates/fields/editlink'](field))
    $(e.target).replaceWith(edit_view)

  clearlink: (e) =>
    edit = $(e.target).parent()
    $('input',edit).val("")
    @readlink(e)


  readlink: (e) =>
    edit = $(e.target).parent()
    name = $('input',edit).first().attr('name')
    $('input').each (i,c)=>
      @model.fields[$(c).attr('name')] = $(c).val()
    @model.save()
    try
      field =
        key: name
        value: @model.fields[name] || "(click to add link)"
        href: @model.fields[name + '_href']
      show_view = $(JST['templates/fields/showlink'](field))
      $(edit).replaceWith(show_view)




  setup_read: (elm) =>
    return @setup_read_link($('a',elm)[0]) if $(elm).hasClass('link')
    @setup_read_content(elm)

  setup_read_content: (elm) =>
    name = elm.id
    field =
      key: name
      value: $(elm).text().trim() || "(click to add text)"
    show_view = $(JST['templates/fields/show'](field))
    $(elm).html(show_view)

  setup_read_link: (elm) =>
    name = $(elm).attr('data-name')
    field =
      key: name
      value: $(elm).text().trim() || "(click to add link)"
      href: $(elm).attr('href')
    show_view = $(JST['templates/fields/showlink'](field))
    $(elm).replaceWith(show_view)
    $(elm).attr('href','#')

  render: (p) =>
    @model = App.Page.first()
    $('.read').addClass('editable')
    @setup_read(elm) for elm in $('.read')
    @


