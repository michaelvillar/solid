View = require('view')

class ButtonView extends View
  tagName: 'button'
  className: 'button'

  constructor: ->
    super
    @$el.on('click', =>
      @fire('click'))

  setTitle: (title) =>
    @$el.text(title)

  setSelected: (selected) =>
    if !selected
      @$el.removeClass('selected')
    else
      @$el.addClass('selected')

module.exports = ButtonView