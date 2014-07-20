class Goal

  def initialize(current_balance, goal_balance, options = {})
    @current_balance = current_balance.to_i
    @goal_balance = goal_balance.to_i
    @minimal_bet_size = options[:minimal_bet_size].to_i
    check_values
  end

  def bets_count
    count = 0
    current = @current_balance
    while current < @goal_balance
      bet_size = current * 0.25
      bet_size = @minimal_bet_size if bet_size < @minimal_bet_size
      koeff = 2.0
      current += bet_size * koeff - bet_size
      count += 1
    end
    count
  end

  def json_bets_count
    {bets_count: bets_count}
  end

  def next_bet_size
    (@current_balance * 0.25 > @minimal_bet_size ? @current_balance * 0.25 : @minimal_bet_size).round
  end

  def json_next_bet_size
    {next_bet_size: next_bet_size}
  end

  private

    def check_values
      @goal_balance = @current_balance if @current_balance > @goal_balance
      check_min_bet_size
    end

    def check_min_bet_size
      @minimal_bet_size = 0 if @goal_balance < @minimal_bet_size || @current_balance < @minimal_bet_size
    end

end