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

  def destroy
    # msg = Mthread.find(params[:thread_id])
    # msg.destroy
    # redirect_to(request.referrer, success: "Message Deleted")
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
    params.permit(:content, :user_id, :mthread_id)
  end
end
