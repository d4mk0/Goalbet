module GoalHelper
  def strategy_list(current_balance, goal_balance, options = {})
    list = []
    min_bet_size = options[:minimal_bet_size]
    min_bet_size = 0 if goal_balance < min_bet_size || current_balance < current_balance

    while current_balance < goal_balance
      bet_size = current_balance * 0.25
      bet_size = min_bet_size if min_bet_size.present? && bet_size < min_bet_size
      list << {
        bet_size: (number_to_currency bet_size, precision: 0),
        koeff: koeff = 2.0,
        win_size: (number_to_currency (win_size = bet_size * koeff), precision: 0),
        summary_balance: (number_to_currency (current_balance += win_size - bet_size), precision: 0)
      }
    end
    list
  end
end
