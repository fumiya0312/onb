class ApplicationController < ActionController::Base
  authorize_resource :class => false
  rescue_from CanCan::AccessDenied do |exception|
    # root_urlにかっ飛ばす。
    redirect_to root_url
  end
end
