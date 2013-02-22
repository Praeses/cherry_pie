class App.Link extends Spine.Controller
  constructor: ->
    super
    @setup_read_link $('a', @el)

  events:
    'click .showlink': 'editlink'
    'click .editlink button#save': 'readlink'
    'click .editlink button#clear': 'clearlink'

  setup_read_link: (elm) =>
    name = $(elm).attr('data-name')
    field =
      key: name
      value: $(elm).text().trim() || "(click to add link)"
      href: $(elm).attr('href')
    show_view = $(JST['templates/fields/showlink'](field))
    $(elm).replaceWith(show_view)
    $(elm).attr('href','#')

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

