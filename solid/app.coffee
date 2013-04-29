#= require_tree .
#= require_tree ../app/

@delay = (ms, func) -> setTimeout func, ms
@clearDelay = (id) -> clearTimeout id

$ ->
  AppController = require('app.controller')
  appController = new AppController()
  $('body').append(appController.view.$el)
