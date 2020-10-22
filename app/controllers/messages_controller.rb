class MessagesController < ApplicationController
    before_action :set_mthread
    before_action :set_message, only: [:show, :edit, :update, :destroy]

  def create
    @message = @mthread.messages.build(message_params)
    if @message.save
      redirect_to(request.referrer, success: "Added Message")
    else
        p @message.errors
        redirect_to(request.referrer, danger: "Unable to add Message")
    end
  end

  def edit
    @message = Message.find(params[:message_id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @message = Message.find(params[:message_id])
    @message.content = params[:content]
    if @message.save
      redirect_to(request.referrer, success: "Edited Successfully")
    else
        p @message.errors
        redirect_to(request.referrer, danger: "Unable to Edit Message")
    end
  end
  
  

  def destroy
    mThread = Mthread.find(params[:mthread_id])
    msg = mThread.messages.find(params[:message_id])
    msg.destroy
    redirect_to(request.referrer, success: "Message Deleted")
  end

  private
  def set_mthread
      @mthread = Mthread.find(params[:mthread_id])
  end

  def set_message
      @message = @mthread.messages.find(params[:message_id])
  end

  # Only allow a trusted parameter "white list" through.
  def message_params
    params.permit(:content, :user_id, :mthread_id, :message_id)
  end
end
