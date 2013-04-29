Solid = require('solid')

PREFIXES = ['-moz', '-webkit', '-o', '-ms']
CSS_KEYS = ['left', 'right', 'top', 'bottom', 'height', 'width', 'opacity']
TRANSFORM_KEYS = ['scale', 'scaleX', 'scaleY', 'scaleZ', 'translate', 'translateX', 'translateY', 'translateZ']

class View extends Solid
  tagName: 'div'
  className: null

  constructor: (@options = {}) ->
    super

    @superview = null
    @subviews = []
    @tagName = @options.tagName if @options.tagName
    @className = @options.className if @options.className

    if @options.el
      @$el = @options.el
    else
      @$el = $(document.createElement(@tagName))
    if @className
      @$el.addClass(@className)

    @on('superviewWillChange', @superviewWillChange_)
    @on('superviewDidChange', @superviewDidChange_)

  # View Hierarchy
  addSubview: (view) =>
    view.fire('superviewWillChange')
    @$el.append(view.$el)
    view.superview = @
    @subviews.push(view) if view != @
    view.fire('superviewDidChange')

  removeFromSuperview: =>
    @fire('superviewWillChange')
    @$el.detach()
    if @superview
      @superview.subviews.splice(@superview.subviews.indexOf(@))
    @superview = null
    @fire('superviewDidChange')

  isInWindow: =>
    parent = @$el
    while parent && parent.length > 0
      if parent[0].tagName.toLowerCase() == 'body'
        return true
      parent = parent.parent()
    return false

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
    cssRenderingDuration = if $.browser.mozilla then 100 else 1
    delay cssRenderingDuration, =>
      @set(args)

    @animationEndTimeout = delay duration + cssRenderingDuration, =>
      animation.fire('end')
      @cssToPrefixes_('transition', 'none')

    animation

  # Private
  cssToPrefixes_: (key, value) =>
    for prefix in PREFIXES
      @$el.css(prefix+key, value)
    @$el.css(key, value)

  # Events
  superviewWillChange_: =>
    @cachedIsInWindowForSuperviewChange_ = @isInWindow()
    for subview in @subviews
      subview.fire('superviewWillChange')

  superviewDidChange_: =>
    for subview in @subviews
      subview.fire('superviewDidChange')
    @fire('isInWindowDidChange') if @isInWindow() != @cachedIsInWindowForSuperviewChange_

module.exports = View