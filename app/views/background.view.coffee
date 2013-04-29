View = require('view')

MAX_HEIGHT = 1000
PADDING_BOTTOM = 100

class BackgroundView extends View
  className: 'backgroundView'

  constructor: ->
    super

    @currentHeight = 0

    @innerView = new View({ className: 'innerBackgroundView' })
    @addSubview(@innerView)

    @innerView.set({ height: MAX_HEIGHT })

  setHeight: (height, duration = 0, curve = null) =>
    if @currentHeight < height
      @set({ height: height + PADDING_BOTTOM })
    args = { translateY: height - MAX_HEIGHT }
    if duration > 0
      animation = @innerView.animate(args, duration, curve)
      animation.on('end', =>
        @set({ height: height + PADDING_BOTTOM })
      )
    else
      @innerView.set(args)
      @set({ height: height + PADDING_BOTTOM })
    @currentHeight = height
    animation

module.exports = BackgroundView