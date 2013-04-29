View = require('view')

textViewShouldHaveFocus = null

class TextView extends View
  tagName: 'input'
  className: 'textview'

  constructor: (@options = {}) ->
    super @options

    @on('isInWindowDidChange', @isInWindowDidChange_)
    @$el.attr('type', @options.type || "text")

  setValue: (value) =>
    @$el.val(value)

  value: =>
    @$el.val()

  focus: =>
    if @isInWindow()
      textViewShouldHaveFocus = null
      @$el.focus()
    else
      @waitForFocus_()

  # Private
  waitForFocus_: =>
    textViewShouldHaveFocus = @

  isInWindowDidChange_: =>
    if @isInWindow()
      @focus()

module.exports = TextView