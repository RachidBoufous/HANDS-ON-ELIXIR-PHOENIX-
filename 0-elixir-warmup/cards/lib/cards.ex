defmodule Cards do


  def hello do
    "hi there" # we don't have to write the return keyword as elixir return the last object on function scope
  end


  def create_deck do

    # creating a list of elements

    ["ACE",  "TWO", "THREE"]

  end


  def shuffle(deck) do # arity: refers to the numbers of arg that a function accepts (shuffe_deck/1)
    Enum.shuffle(deck)
  end


end
