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
    ["ACE",  "TWO", "THREE"] # this is immutable -> after we call shuffle on this Data structure won't be modified
                             # shuffle will create a copy of this data structure and return the shuffled version
  end


  @spec shuffle([String]) :: [String]
  @doc """
      returns a shuffled copy of a given deck
    """
  def shuffle(deck) do # arity: refers to the numbers of arg that a function accepts (shuffe_deck/1)
    Enum.shuffle(deck)
  end

  @spec contains([String], String) :: Boolean
  @doc """
      checks if a deck contains a given card.
  """
  def contains(deck, card) do
    Enum.member?(deck, card)
  end



end
