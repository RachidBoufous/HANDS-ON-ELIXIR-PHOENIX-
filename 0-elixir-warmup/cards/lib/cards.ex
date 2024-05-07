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



  @spec save(deck :: any(), filename :: String) :: :ok
  @doc """
    takes a deck and saves into a file with specified file name*
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @spec load(filename:: String) :: :ok
  @doc """
    load a deck from a a given file in the fs
  """
  def load(filename) do # if file doesn't exist it will throw enoent which is no entity

    {status, binary } = File.read(filename)

    case status do
      :ok -> :erlang.binary_to_term(binary) # :ok :error are called atom > can be used for status codes, flow controle, or messages
      :error -> "file does not exist"
      # Atoms can be think of as a string -> they can be used as some sort of response messages only developers see
    end
  end


  def load2(filename) do
    case File.read(filename)
    do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> "error was thrown: #{reason}"
    end
  end


  @spec create_hand(hand_size::Integer) :: :ok
  @doc """
    this function will do the following:
      1. create a deck
      2. shuffle that deck
      3. deal a hand_size hand of it
  """

  def create_hand(hand_size) do
    # passing data from function to function it's common -> elixir has it's own way of doing it called "PIPE operator"
    # deck = create_deck()
    # deck = shuffle(deck)
    # deal(deck, hand_size)


    # using PIPE

    create_deck()
    |> shuffle() # PIPE here will auto inject the result in the next function first argument
    |> deal(hand_size) # to use PIPE it has to be on first arg and only first arg, anything else won't work
  end


end
