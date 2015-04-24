class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_path(path)
  	last_path = path.split('/').last rescue nil
  	if last_path
  	  if %w{edit add}.include?(last_path)
  	    path = path.gsub('/' + last_path, '')
      end
    end
    '/' + path.to_s
  end
end
