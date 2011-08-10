class Parish extends Backbone.Model

class ParishCollection extends Backbone.Collection
  model: Parish
  fayeStorage: new Store 'parish'

