class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_submitted.subject
  #
  def order_submitted(order)
    @order = order

    mail(
      to: 'mansoor@caremeds.co.uk',
      subject: "New order from #{@order.user.forname} - Order# #{@order.id}"
    )
  end
end
