defmodule Cards do


  def hello do
    "hi there" # we don't have to write the return keyword as elixir return the last object on function scope
  end

  @spec create_deck() :: [String]
  @doc """
      returns an orderd deck
  """
  def create_deck do
    # creating a list of elements
    values = ["ACE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE", "TEN", "JACK", "QUEEN", "KING"]
    # this is immutable -> after we call shuffle on this Data structure won't be modified
    # shuffle will create a copy of this data structure and return the shuffled version

    suits = ["SPADES", "CLUBS", "HEARTS", "DIAMONDS"]

    # this nested loops over here will produce a list of lists
    # goal is to get a list of string like the spec stats
    # to solve this we gonna be using list <linked lists ds> using flatten
    cards = for suit <- suits do
      for value <- values  do
        # value <> " OF " <> suit # concatination approach
        "#{value} OF #{suit}"  # interpolation approach
      end
    end

    List.flatten(cards)

  end


  @spec shuffle([String]) :: [String]
  @doc """
      returns a shuffled copy of a given deck
    """
  def shuffle(deck) do # arity: refers to the numbers of arg that a function accepts (shuffe_deck/1)
    Enum.shuffle(deck)
  end

  @spec contains?([String], String) :: Boolean
  @doc """
      checks if a deck contains a given card.
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end



end
