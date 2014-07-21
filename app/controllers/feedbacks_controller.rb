class FeedbacksController < ApplicationController
  
  before_action :clear_flash_error, only: :create

  def new
    @feedback = Feedback.new
  end
  
  def create
    @feedback = Feedback.new(feedback_params)
    flash[:error] = nil
    unless @feedback.save
      flash[:error] = t('feedback.enter_all_details')
      render :new
    end
  end
  
  private
  
    def feedback_params
      params.require(:feedback).permit(:user_name, :subject, :text)
    end

    def clear_flash_error

    end
end
