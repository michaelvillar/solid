View = require('view')

SectionController = require('section.controller')

class HomeController extends SectionController
  sectionViewClassName: 'homeView'
  sectionViewHeight: 200

  constructor: ->
    super

    @view.$el.text('home')

module.exports = HomeController