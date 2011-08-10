(function() {
  var Parish, ParishCollection, Post, PostCollection, School, SchoolCollection, Store, Teacher, TeacherCollection;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.Store = Store = (function() {
    function Store(channel, options) {
      this.options = options != null ? options : {
        bayeux: '/faye'
      };
      _.bindAll(this, 'on_message');
      this.channel = '/models/' + channel;
      this.server_channel = '/server/models/' + channel;
      this.bayeux = new Faye.Client(this.options.bayeux);
    }
    Store.prototype.write = function(message) {
      return this.bayeux.publish(this.channel, message);
    };
    Store.prototype.on_message = function(message) {
      return this[message.method](message.model);
    };
    Store.prototype.read = function(model) {
      if (this.collection.get(model)) {
        return this.update(model);
      } else {
        return this.create(model);
      }
    };
    Store.prototype.create = function(model) {
      return this.collection.add(model);
    };
    Store.prototype.update = function(model) {
      return this.collection.get(model).set(model);
    };
    Store.prototype["delete"] = function(model) {
      var _ref;
      return ((_ref = this.collection.get(model).view) != null ? _ref.remove() : void 0) && this.collection.remove(model);
    };
    return Store;
  })();
  Backbone.sync = function(method, model, success, error) {
    var message, store;
    if (model.fayeStorage != null) {
      method = 'readAll';
      store = model.fayeStorage;
      store.collection = model;
    } else {
      store = model.collection.fayeStorage;
      store.collection = model.collection;
    }
    message = {
      method: method,
      model: model
    };
    return store.write(message);
  };
  Parish = (function() {
    __extends(Parish, Backbone.Model);
    function Parish() {
      Parish.__super__.constructor.apply(this, arguments);
    }
    return Parish;
  })();
  ParishCollection = (function() {
    __extends(ParishCollection, Backbone.Collection);
    function ParishCollection() {
      ParishCollection.__super__.constructor.apply(this, arguments);
    }
    ParishCollection.prototype.model = Parish;
    ParishCollection.prototype.fayeStorage = new Store('parishes');
    return ParishCollection;
  })();
  Post = (function() {
    __extends(Post, Backbone.Model);
    function Post() {
      Post.__super__.constructor.apply(this, arguments);
    }
    return Post;
  })();
  PostCollection = (function() {
    __extends(PostCollection, Backbone.Collection);
    function PostCollection() {
      PostCollection.__super__.constructor.apply(this, arguments);
    }
    PostCollection.prototype.model = Post;
    return PostCollection;
  })();
  School = (function() {
    __extends(School, Backbone.Model);
    function School() {
      School.__super__.constructor.apply(this, arguments);
    }
    return School;
  })();
  SchoolCollection = (function() {
    __extends(SchoolCollection, Backbone.Collection);
    function SchoolCollection() {
      SchoolCollection.__super__.constructor.apply(this, arguments);
    }
    SchoolCollection.prototype.model = School;
    return SchoolCollection;
  })();
  Teacher = (function() {
    __extends(Teacher, Backbone.Model);
    function Teacher() {
      Teacher.__super__.constructor.apply(this, arguments);
    }
    return Teacher;
  })();
  TeacherCollection = (function() {
    __extends(TeacherCollection, Backbone.Collection);
    function TeacherCollection() {
      TeacherCollection.__super__.constructor.apply(this, arguments);
    }
    TeacherCollection.prototype.model = Teacher;
    return TeacherCollection;
  })();
}).call(this);
