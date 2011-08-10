class Teacher extends Backbone.Model

class TeacherCollection extends Backbone.Collection
  model: Teacher
  fayeStorage: new Store 'teacher'
