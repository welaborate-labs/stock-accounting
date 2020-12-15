class FormsMailer < ApplicationMailer

  def contact_us(contact_params)
    @contact = contact_params
    mail(to: 'contact@welaborate.com', subject: "Message from #{@contact[:email]}" )
  end
end
