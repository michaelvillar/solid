View = require('view')

SectionController = require('section.controller')

class LoggedController extends SectionController
  sectionViewClassName: 'loggedView'
  sectionViewHeight: 350

  constructor: ->
    super

    @view.$el.text('logged')

module.exports = LoggedController