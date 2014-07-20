class Api::GoalController < ApplicationController

  before_action :get_goal

  def bets_count
    render json: @goal.json_bets_count
  end

  def next_bet_size
    render json: @goal.json_next_bet_size
  end

  private

    def get_goal
      @goal = Goal.new cookies[:current_balance], cookies[:goal], minimal_bet_size: cookies[:minimal_bet_size]
    end
end