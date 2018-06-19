class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_submitted.subject
  #
  def order_submitted
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
