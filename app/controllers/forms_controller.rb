class FormsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:submit_contact]
  skip_before_action :check_subscription!, only: [:submit_contact]
  before_action :set_contact, only: [:submit_contact]

  def submit_contact
    if @contact.valid?
      FormsMailer.contact_us(contact_params).deliver_now
      flash[:notice] = t('.notice')
    else
      flash[:alert] = t('.alert')
    end

    redirect_to root_path
  end

  private
    def contact_params
      params.require(:contact).permit(:email, :message)
    end

    def set_contact
      @contact = ContactUsForm.new
      @contact.email = contact_params[:email]
      @contact.message = contact_params[:message]
    end
end
