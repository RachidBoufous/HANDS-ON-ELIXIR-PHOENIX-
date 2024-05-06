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
    # solution #1
    # # this nested loops over here will produce a list of lists
    # # goal is to get a list of string like the spec stats
    # # to solve this we gonna be using list <linked lists ds> using flatten
    # cards = for suit <- suits do
    #   for value <- values  do
    #     # value <> " OF " <> suit # concatination approach
    #     "#{value} OF #{suit}"  # interpolation approach
    #   end
    # end

    # List.flatten(cards)


    # solution #2

    for suit <- suits,  value <- values do
          "#{value} OF #{suit}"  # interpolation approach
      end

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


  @spec deal([String], Integer) :: [String]
  @doc """
    deals a given number of random cards from a given deck
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)  # this will return a tuple {elem, elem}
    # we can't do random access on elixir, but we do have matching patterns
    # {my_cards, rest} = Enum.split(deck, hand_size) -> now my_cards has hand_size of cards, rest, has the rest of elements
  end


  # Elixir code doesn't execute direclty as it is.... it has to go through multiple steps.
  # 1. code gets fed into elixir runtime
  # 2. transpiles all the code into Erlang (Erlang: was developed for telecoms but erlang has this weird syntax, so we write elixir as a
  # dialect of erlang - so all code ends up runing by erlang anyways -  elxiri sole purpose is to give us an easier interface to erlang)
  # 3. then it will be compiles and executed into something called "BEAM" (BEAM - BOGDAN SLASH BJORN'S ERLANG ABSTRACT MACHINE | BEAM is
  # a virtual machine in which all of our code will gets executed BEAM for elixir is like JVM for JAVA)

  # NOTE: some parts of erlang are not fully transpiled to elixir so we have to tap in to erlang to get access to certain system functionalities
  # EX: file system -  to use FS u have to write some erlang code.



  @spec save(deck, filename)
  @doc """
    takes a deck and saves into a file with specified file name*

  """
  def deal(deck, filename) do

    binary - :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end


end
