class SessionsController < ApplicationController

  def clear
    reset_session
    redirect_to "/"
  end

  def feedback
    FeedbackMailer.feedback(params[:name], params[:comment]).deliver

    render :json => { :success => true }
  end
end
