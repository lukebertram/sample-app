class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: "Hold onto your butts!"
  end
end
