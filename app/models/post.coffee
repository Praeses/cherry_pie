class Post extends Backbone.Model

class PostCollection extends Backbone.Collection
  model: Post
  fayeStorage: new Storage 'post'
