class ApplicationController < ActionController::Base  
  skip_before_action :verify_authenticity_token

  def static
 	  head :no_content
  end
end
