#= require_tree .
#= require_tree ../app/

@delay = (ms, func) -> setTimeout func, ms
@clearDelay = (id) -> clearTimeout id
@log = -> console.log.apply(console, arguments)

$ ->
  View = require('view')
  AppController = require('app.controller')

  appController = new AppController()
  body = new View({ el: $('body') })
  body.addSubview(appController.view)
