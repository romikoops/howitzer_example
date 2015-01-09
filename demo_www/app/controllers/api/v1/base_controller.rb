require "application_responder"

class API::V1::BaseController < ActionController::Base
  self.responder = ApplicationResponder

  private

  def default_serializer_options
    {
        root: false
    }
  end

end