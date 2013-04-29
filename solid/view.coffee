Solid = require('solid')

PREFIXES = ['-moz', '-webkit', '-o', '-ms']
CSS_KEYS = ['left', 'right', 'top', 'bottom', 'height', 'width', 'opacity']
TRANSFORM_KEYS = ['scale', 'scaleX', 'scaleY', 'scaleZ', 'translate', 'translateX', 'translateY', 'translateZ']

class View extends Solid
  tagName: 'div'
  className: null

  constructor: (@options = {}) ->
    super

    @tagName = @options.tagName if @options.tagName
    @className = @options.className if @options.className

    @$el = $(document.createElement(@tagName))
    if @className
      @$el.addClass(@className)

  # View Hierarchy
  addSubview: (view) =>
    @$el.append(view.$el)

  removeFromSuperview: =>
    @$el.detach()

  # View Position
  height: =>
    parseInt(@$el.css('height'))

  setHeight: (height) =>
    @$el.css('height', height)

  setPositionAbsolute: =>
    @$el.css('position', 'absolute')

  set: (args) =>
    for key in CSS_KEYS
      @$el.css(key, args[key]) if args[key] != undefined

    transform = []
    for key in TRANSFORM_KEYS
      value = args[key]
      if value != undefined
        value = parseInt(value) + "px" if key.match(/translate/)
        transform.push(key+'('+value+')')

    @cssToPrefixes_('transform', transform.join(' '))

  # Animations
  animate: (args, duration, curve = 'ease-in-out') =>
    clearDelay(@animationEndTimeout)
    animation = new Solid

    @cssToPrefixes_('transition', duration + 'ms ' + curve)
    delay 1, =>
      @set(args)

    @animationEndTimeout = delay duration, =>
      animation.fire('end')
      @cssToPrefixes_('transition', 'none')

    animation

  # Private
  cssToPrefixes_: (key, value) =>
    for prefix in PREFIXES
      @$el.css(prefix+key, value)
    @$el.css(key, value)

module.exports = View