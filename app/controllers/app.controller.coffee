Controller = require('controller')
View = require('view')

HomeController = require('home.controller')
PaymentController = require('payment.controller')
LoggedController = require('logged.controller')

ButtonView = require('button.view')
BackgroundView = require('background.view')

easingCurves = require('easingCurves')

class AppController extends Controller
  currentController: null

  constructor: ->
    super

    @view = new View({ className: 'mainView' })
    @nav = new View({ className: 'navView', tagName: 'nav' })
    @contentView = new View({ className: 'mainContentView' })
    @backgroundView = new BackgroundView
    @backgroundView.set({ left: 0, top: 0, right: 0 })

    @view.addSubview(@backgroundView)
    @view.addSubview(@nav)
    @view.addSubview(@contentView)

    @homeButton = new ButtonView
    @homeButton.setTitle("Home")
    @homeButton.on('click', @homeButtonClickAction)
    @nav.addSubview(@homeButton)

    @paymentButton = new ButtonView
    @paymentButton.setTitle("Payment")
    @paymentButton.on('click', @paymentButtonClickAction)
    @nav.addSubview(@paymentButton)

    @loggedButton = new ButtonView
    @loggedButton.setTitle("Logged")
    @loggedButton.on('click', @loggedButtonClickAction)
    @nav.addSubview(@loggedButton)

    @buttons = [@homeButton, @paymentButton, @loggedButton]

    @homeController = new HomeController
    @paymentController = new PaymentController
    @loggedController = new LoggedController

    @setSelectedButton(@homeButton)
    @goToController(@homeController)

    @view.set({ opacity: 0, scale: 0.8, translateY: 100 })
    @view.animate({ opacity: 1, scale: 1, translateY: 0 }, 400, easingCurves.bouncingCurve)

  # Actions
  homeButtonClickAction: (button) =>
    @setSelectedButton(button)
    @goToController(@homeController, true)

  paymentButtonClickAction: (button) =>
    @setSelectedButton(button)
    @goToController(@paymentController, true)

  loggedButtonClickAction: (button) =>
    @setSelectedButton(button)
    @goToController(@loggedController, true)

  # Private
  setSelectedButton: (button) =>
    for aButton in @buttons
      aButton.setSelected(false)
    button.setSelected(true)

  goToController: (controller, animated = false) =>
    return if controller == @currentController
    oldController = @currentController
    if oldController
      animation = oldController.hide(animated)
      if animated
        animation.on('end', =>
          oldController.view.removeFromSuperview()
        )
      else
        oldController.view.removeFromSuperview()

    @currentController = controller
    @contentView.addSubview(@currentController.view)
    @currentController.show(animated)

    newHeight = 50 + @currentController.sectionViewHeight + 15
    if animated
      @backgroundView.setHeight(newHeight, 400, easingCurves.bouncingCurve)
    else
      @backgroundView.setHeight(newHeight)

module.exports = AppController