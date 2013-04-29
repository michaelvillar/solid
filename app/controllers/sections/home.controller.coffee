View = require('view')

SectionController = require('section.controller')
TextView = require('text.view')

class HomeController extends SectionController
  sectionViewClassName: 'homeView'
  sectionViewHeight: 200

  constructor: ->
    super

    @view.$el.text('home')

    @textView = new TextView({ type: 'email' })
    @textView.setName('email')
    @textView.setSpellCheckingEnabled(false)
    @textView.setAutocompleteType('email')
    @view.addSubview(@textView)

  show: =>
    super

    @textView.focus()

module.exports = HomeController