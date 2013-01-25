class App.Pages extends Spine.Controller

  constructor: ->
    super
    App.Page.bind "refresh", @onPageLoad
    App.Page.fetch {id: App.page_id}

  onPageLoad: (p) =>
    page = App.Page.first()
    console.log page
