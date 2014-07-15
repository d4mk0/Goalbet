class GoalController < ApplicationController

  before_action :set_goal, :set_current_balance, :set_minimal_bet_size, except: :landing
  before_action :whether_to_show_landing?, only: :landing

  def landing
    render layout: 'landing'
  end

  def reach
    @values = {
      reached_progress: (@goal*0.01).to_i,
      minimal_bet_size: @minimal_bet_size
    }
  end

  def strategy
    render partial: 'strategy'
  end

  private

    def set_goal
      params_goal = params[:goal].present? ? params[:goal].delete!(' ') : params[:goal]
      goal = params_goal.to_i > 0 ? params[:goal].to_i : (cookies[:goal].to_i > 0 ? cookies[:goal].to_i : 1000000) 
      cookies[:goal] = {value: goal, expires: 1.year.from_now} if cookies[:goal].to_i != goal
      @goal = cookies[:goal].to_i
    end

    def set_current_balance
      @current_balance = cookies[:current_balance].to_i > 0 ? cookies[:current_balance].to_i : @goal*0.01
      cookies[:current_balance] = @current_balance if cookies[:current_balance].to_i != @current_balance
    end

    def set_minimal_bet_size
      @minimal_bet_size = cookies[:minimal_bet_size].to_i
      cookies[:minimal_bet_size] = @minimal_bet_size if cookies[:minimal_bet_size].to_i != @minimal_bet_size
    end

    def whether_to_show_landing?
      redirect_to :reach and return if cookies[:goal].present? && (request.referer.blank? || URI(request.referer).path != '/reach')
    end
end
