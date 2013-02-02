class SessionsController < ApplicationController

  def clear
    reset_session
    redirect_to "/"
  end

  def feedback
    FeedbackMailer.feedback(params[:name], params[:comment], request.referrer).deliver

    render :json => { :success => true }
  end
end
