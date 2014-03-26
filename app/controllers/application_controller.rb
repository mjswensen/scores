class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  	# The action that responds to the user's initial request.
  	# The view for this action will serve up all of our Angular code.
  end
end
