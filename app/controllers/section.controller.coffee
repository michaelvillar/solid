Controller = require('controller')
View = require('view')

HIDDEN_CSS = { scale: 1.1, translateY: -10 }
VISIBLE_CSS = { opacity: 1, scale: 1, translateY: 0 }
HIDING_CSS = { opacity: 0, scale: 0.9, translateY: 10 }

class SectionController extends Controller
  sectionViewClassName: null
  sectionViewHeight: 0

  constructor: ->
    super

    @view = new View({ className: @sectionViewClassName + ' sectionView', tagName: 'section' })
    @view.setPositionAbsolute()
    @view.set($.merge({ left: 0, top: 0, right: 0, height: @sectionViewHeight, opacity: 0 }, HIDDEN_CSS))

  show: (animated) =>
    if !animated
      @view.set(VISIBLE_CSS)
    else
      @view.set(HIDDEN_CSS)
      @view.animate(VISIBLE_CSS, 300)

  hide: (animated) =>
    if animated
      animation = @view.animate(HIDING_CSS, 300)
      animation.on('end', =>
        @view.set(HIDDEN_CSS)
      )
      animation
    else
      @view.set(HIDDEN_CSS)

module.exports = SectionController