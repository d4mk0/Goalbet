class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_titles

  private

    def set_titles
      set_nav_title
      set_meta_title
    end

    def set_nav_title
      @nav_title = Settings.nav_title
    end

    def set_meta_title
      @meta_title = Settings['meta.title']
    end
end
