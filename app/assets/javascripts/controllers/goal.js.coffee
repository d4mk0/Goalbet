GoalController = Paloma.controller('Goal')

GoalController.prototype.reach = ->
  set_progress_bar_percentage = (percent) ->
    $("#reach-progress .percent").html(percent)
    $("#reach-progress .progress-bar").css("width", "#{percent}%")

  update_progress = (current_balance = $.cookie('current_balance'))->
    goal_balance = $("#current_balance_slider").data('goal')
    percent_of_reaching = Math.floor((parseInt(current_balance,10) / parseInt(goal_balance,10))*100)
    set_progress_bar_percentage percent_of_reaching
    $("#current_balance, #current_balance_slider").val(current_balance)
    multiply_size = goal_balance/current_balance
    multiply_size += 0.01 unless multiply_size-Math.floor != 0.0
    $("#multiply_size").html(multiply_size.toFixed 2)

    $.cookie 'current_balance', current_balance, 
      expires: 365
    $.cookie 'current_progress', percent_of_reaching,
      expires: 365
    updateBetsCount()
    updateNextBetSize()

  updateBetsCount = ->
    $.ajax
      url: '/api/bets_count'
      success: (data, textStatus, jqXHR) ->
        $("#bets_count").html data.bets_count

  updateNextBetSize = ->
    $.ajax
      url: '/api/next_bet_size'
      success: (data, textStatus, jqXHR) ->
        $("#next_bet_size").html data.next_bet_size

  howManyBets = (current_balance, goal_balance) ->
    count_of_bets = 0
    balance = current_balance
    while balance < goal_balance
      balance *= 1.25
      count_of_bets++
    count_of_bets

  set_progress_bar_percentage $.cookie('current_progress') if $.cookie('current_progress')
  update_progress()
  $("#help_bets-count,
    .current_bet_buttons button").tooltip()

  $("#current_balance_slider").noUiSlider
    start: parseInt($.cookie('current_balance') || 1, 10)
    range:
      min: 1
      max: $("#current_balance_slider").data('goal')
    serialization:
      lower: [$.Link(target: $("#current_balance"))]
      format:
        decimals: 0

  $("#current_balance_slider").on 'slide', ->
    update_progress($(@).val())

  $("#current_balance").on 'change', ->
    update_progress($(@).val())

  $("#help_bets-count").on 'click', ->
    $("#bets_strategy-modal .modal-body").load $(this).data("strategy-path"), ->
      $("#bets_strategy-modal").modal 'show'

  $("#minimal_bet_size").editable
    emptytext: '0'
    mode: 'inline'
    success: (resp, value) ->
      $.cookie 'minimal_bet_size', value, 
        expires: 365
      update_progress()
      return
    validate: (value) ->
      if /^\d*$/.test value
        return 'Min bet must be less current_balance' if value > parseInt($("#current_balance").val(), 10)
      else
        return 'Only digits available here'

  plusMinusClick = (plus = true) ->
    current = parseInt($("#current_balance").val(), 10)
    bet = parseInt($("#next_bet_size").html(), 10)
    current_balance = if plus then current+bet else current-bet
    $("#current_balance").val(current_balance)
    update_progress(current_balance)

  $(".current_bet_buttons .btn-success").on 'click', ->
    plusMinusClick()

  $(".current_bet_buttons .btn-danger").on 'click', ->
    plusMinusClick false

GoalController.prototype.strategy = ->
  modal = $('#bets_strategy-modal')
  $(modal).scroll ->
    $("#balance-info", modal).css top: (if modal.scrollTop() > 95 then modal.scrollTop() - 120 else -14) + "px" 

GoalController.prototype.landing = ->
  $("#goal").autoNumeric "init",
    aSep: ' '
    mDec: '0'
