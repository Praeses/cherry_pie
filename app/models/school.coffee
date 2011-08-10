class School extends Backbone.Model

class SchoolCollection extends Backbone.Collection
  model: School
  fayeStorage: new Store 'school'
