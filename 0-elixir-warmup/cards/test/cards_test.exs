defmodule CardsTest do
  use ExUnit.Case
  doctest Cards


  # in elxir there is two type of test we can run
  # 1. Assertion or Case tests
  # 2. Doc Testing are the ones direclty writing in the docs of a function in elixir code.
  # While adding docs, if we add a ## Examples and we put a valid elixir code, elixir then will also validate that and will run it as a test.

  # this is a test, each test starts with keyword test, and it has a description
  test "create deck makes 20 cards" do
    deck_length = length(Cards.create_deck())
    assert deck_length == 52 # here we assert the numbers of cards withing a deck should be 52 and exactly 52
  end

end
