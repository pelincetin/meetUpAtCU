class MessagesController < ApplicationController
    def create
        if session[:user_id].blank?
          flash[:notice] = "Please create a profile using your uni and login"
          redirect_to profiles_path
          return 
        end
        params[:message][:to_uni] = params[:to_uni]
        @message = Message.create!(message_params)
        @recipient = Profile.find_by(uni: @message[:to_uni])
        @sender = Profile.find_by(uni: session[:user_id])
        @text = @message[:text]
        puts @recipient.uni
        puts "sender"
        puts @sender.uni
        puts "recipeint"
        puts @recipient
        puts "text"
        puts @text
        MessageMailer.with(recipient: @recipient, sender: @sender, text: @text).email_comm.deliver_now
        flash[:notice] = "Your message to #{params[:name]} was successfully sent."
        redirect_to profiles_path
    end
  
    def random_create
        @recipient = Profile.random_select(session[:user_id])
        if @recipient.nil?
          flash[:notice] = "Unfortunately, we don’t have enough users with random matching opted in right now. Please check back later!"
          redirect_to profiles_path
          return
        end
        #params[:message][:to_uni] = @recipient.uni
        #@message = Message.create!(message_params)
        @sender = Profile.find_by(uni: session[:user_id])
        puts @recipient.uni
        puts "sender"
        puts @sender.uni
        puts "recipeint"
        puts @recipient
        MessageMailer.with(recipient: @recipient, sender: @sender).random_call.deliver_now
        flash[:notice] = "You and #{@recipient.name} were successfully matched."
        redirect_to profiles_path
    end

    private

    def message_params
        params.require(:message).permit(:text, :to_uni, :created_at, :updated_at)
    end
end
