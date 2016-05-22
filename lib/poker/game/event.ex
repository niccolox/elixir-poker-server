defmodule Poker.Game.Event do
  defstruct [
    id: "", 
    player_id: nil,
    game_id: nil,
    type: nil, 
    amount: nil,
    phase: nil
  ]

  alias Poker.Game.Event

  def new(type: type, amount: amount) do
    %Event{
      id: generate_id,
      type: type,
      amount: amount,
    }
  end

  def new(type: type, phase: phase) do
    %Event{
      id: generate_id,
      type: type,
      phase: phase,
    }
  end

  def new(type: type) do
    %Event{
      id: generate_id,
      type: type
    }
  end

  def call(amount: amount) do
    Event.new(type: :call, amount: amount)
  end

  def raise(amount: amount) do
    Event.new(type: :raise, amount: amount)
  end

  def fold do
    Event.new(type: :fold)
  end

  def check do
    Event.new(type: :check)
  end

  def phase_transition(next_phase) when next_phase in [:preflop, :flop, :turn, :river, :showdown] do
    Event.new(type: :phase_transition, phase: next_phase)
  end

  def specify_player(action, player_id) do
    %Event{ action | 
      player_id: player_id
    }
  end

  def specify_game(action, game_id) do
    %Event{ action | 
      game_id: game_id
    }
  end

  defp generate_id do
    "table_action_" <> (UUID.uuid4(:hex) |> String.slice(0, 8))
  end
end
