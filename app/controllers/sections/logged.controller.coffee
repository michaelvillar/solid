View = require('view')

SectionController = require('section.controller')
TextView = require('text.view')

class LoggedController extends SectionController
  sectionViewClassName: 'loggedView'
  sectionViewHeight: 350

  constructor: ->
    super

    new TextView

    @view.$el.text('logged')

module.exports = LoggedController