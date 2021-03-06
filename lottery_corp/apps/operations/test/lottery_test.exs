defmodule LotteryTest do
  use ExUnit.Case
  # doctest LotteryCorp


  # alias LotteryCorp.Operations

  test "Add player to game" do
    {:ok, game_id} = LotteryCorp.Operations.create_game()
    LotteryCorp.Operations.add_player(game_id, "Mick")
    {:ok, _game_state} = LotteryCorp.Operations.get_game(game_id)
    # IO.inspect(game_state)
  end

  test "Supervisor" do
    {:ok, sup} = LotteryCorp.Operations.Game.Supervisor.start_link([])
    {:ok, game} = LotteryCorp.Operations.Game.Supervisor.start_game(sup, 1202)
    {:ok, _t} = LotteryCorp.Operations.Game.add_player(game, "Zane")
    # IO.inspect(t)
  end

  test "Registry" do
    # {:ok, registry} = LotteryCorp.Operations.Game.Registry.start_link()
    {:ok, game} = LotteryCorp.Operations.Game.Registry.lookup(LotteryCorp.Operations.Game.Registry, 100)
    {:ok, _t} = LotteryCorp.Operations.Game.add_player(game, "Zane")
    # IO.inspect(t)
  end

  test "lifecycle" do
    {:ok, game} = LotteryCorp.Operations.create_game()

    {:error, :no_players_to_win} = LotteryCorp.Operations.pick_winner(game) # randomiser
    {:ok, _t} = LotteryCorp.Operations.add_player(game, "Adam")
    {:ok, _t} = LotteryCorp.Operations.add_player(game, "Bill")
    {:ok, _t} = LotteryCorp.Operations.add_player(game, "Clive")
    {:ok, _t} = LotteryCorp.Operations.add_player(game, "Clive")
    {:ok, _t} = LotteryCorp.Operations.add_player(game, "Dan")
    {:ok, _t} = LotteryCorp.Operations.remove_player(game, "Dan")
    {:ok, _t} = LotteryCorp.Operations.remove_player(game, "Edward")
    {:ok, _t} = LotteryCorp.Operations.pick_winner(game) # randomiser
    {:error, :lottery_closed} = LotteryCorp.Operations.pick_winner(game) # randomiser
    {:error, :lottery_closed} = LotteryCorp.Operations.add_player(game, "Fred")
    {:error, :lottery_closed} = LotteryCorp.Operations.add_player(game, "George")
  end

# Have listing for global names
# Have editable prize for lottery
# Take snap shot of delivered prize when wins.
# Have an authority when issuing commands

  # Test the game registry
  # - when it creates a game then the number of children on the game supervisor should go up by one
  # - it should register under its module name in global
  # - it should return the same pid after registering(this is only requrement as addind to supervisor is incidental)
  #  - Added to supervisor is not with the intention of restarting
  # - registry needs to call event store with name
  # - spinning up a game if there is no initial event should fail
end
