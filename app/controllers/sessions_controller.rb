class SessionsController < ApplicationController

  def clear
    reset_session
    redirect_to "/"
  end
end
