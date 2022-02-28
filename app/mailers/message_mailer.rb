class MessageMailer < ApplicationMailer
  default from: "meetupatcu@gmail.com"

  def email_comm
    @recipient = params[:recipient]
    puts @recipient
    puts "______________________________________________________________________________"
    puts "______________________________________________________________________________"
    puts "______________________________________________________________________________"
    puts "______________________________________________________________________________"
    if @recipient
      @sender = params[:sender]
      @text = params[:text]
      mail(to: @recipient.email, subject: 'New Message from another user')
    end
  end
  
  def random_call
    @recipient = params[:recipient]
    puts @recipient
    puts "______________________________________________________________________________"
    puts "______________________________________________________________________________"
    puts "______________________________________________________________________________"
    puts "______________________________________________________________________________"
    if @recipient
      @sender = params[:sender]
      mail(to: @recipient.email, subject: 'Random match', cc: @sender.email)
    end
  end
end
