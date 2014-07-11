module GoalHelper
  def strategy_list(current_balance, goal_balance)
    list = []

    while current_balance < goal_balance
      list << {
        bet_size: (number_to_currency (bet_size = current_balance * 0.25), precision: 2),
        koeff: koeff = 2.0,
        win_size: (number_to_currency (win_size = bet_size * koeff), precision: 2),
        summary_balance: (number_to_currency (current_balance + win_size - bet_size), precision: 2)
      }
      current_balance *= 1.25
    end
    list
  end
end
