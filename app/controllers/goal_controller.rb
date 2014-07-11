class GoalController < ApplicationController

  before_action :set_goal, only: [:landing, :reach]

  def landing
    render layout: 'landing'
  end

  def reach
    @values = {
      reached_progress: (@goal*0.01).to_i
    }
  end

  private

    def set_goal
      goal = params[:goal].to_i > 0 ? params[:goal].to_i : (cookies[:goal].to_i > 0 ? cookies[:goal].to_i : 1000000)
      cookies[:goal] = {value: goal, expires: 1.year.from_now} if cookies[:goal].to_i != goal
      @goal = cookies[:goal].to_i
    end

end
