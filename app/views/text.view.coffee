View = require('view')

textViewShouldHaveFocus = null

class TextView extends View
  tagName: 'input'
  className: 'textview'

  constructor: (@options = {}) ->
    super @options

    @on('isInWindowDidChange', @isInWindowDidChange_)
    @$el.attr('type', @options.type || "text")

  setName: (name) =>
    @$el.attr('name', name)

  setValue: (value) =>
    @$el.val(value)

  value: =>
    @$el.val()

  setSpellCheckingEnabled: (enabled) =>
    @$el.attr('spellcheck', if enabled then 'on' else 'off')
    @$el.attr('autocorrect', if enabled then 'on' else 'off')

  setAutocompleteType: (autocompleteType) =>
    @$el.attr('autocompletetype', autocompleteType)

  focus: =>
    if @isInWindow()
      textViewShouldHaveFocus = null
      @$el.focus()
    else
      textViewShouldHaveFocus = @

  # Events
  isInWindowDidChange_: =>
    if @isInWindow()
      @focus()

module.exports = TextView