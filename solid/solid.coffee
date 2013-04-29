class Solid
  constructor: ->
    @events_ = {}

  on: (event, func) =>
    if !@events_[event]
      @events_[event] = []
    @events_[event].push(func)

  fire: (event) =>
    return unless @events_[event]
    for func in @events_[event]
      func(@)

module.exports = Solid