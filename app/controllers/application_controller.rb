class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :login_obrigatorio
  before_action :set_hosts

  private 

    def login_obrigatorio
      unless logged_in?
        flash[:info] = 'Faça login primeiro.'
        redirect_to(login_url)
      end
    end

    def set_hosts
      @hosts = current_user.hosts.all
    end
end
