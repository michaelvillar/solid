View = require('view')

SectionController = require('controllers/section.controller')

class PaymentController extends SectionController
  sectionViewClassName: 'paymentView'
  sectionViewHeight: 400

  constructor: ->
    super

    @view.$el.text('payment')

module.exports = PaymentController