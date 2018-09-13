class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.completed.subject
  #
  def order_submitted(order)
    @order = order

    mail(
      to: 'mansoor@caremeds.co.uk',
      subject: "New order from #{@order.user.forname} - Order# #{@order.id}"
    )
  end

  def order_dispatched(dispatched_order)
    @dispatched_order = dispatched_order

    mail(
      to: dispatched_order.user.email,
      subject: "Order# #{dispatched_order.id} successfully dispatched"
    )

  end
end
