defmodule Identicon do
  @moduledoc """
  Build an identicon image generator, like the one github uses for their profile pics.
  - specifications:
    /size: 250px * 250px
    /contains 5 * 5 squares that are 50 * 50
    /always mirrored around the center axis on left and right.

  -> it is not randomly generated, it will be generated based on a given string
     if we provide the same string twice, the same identicon should be produced.
  """

 
  def main(input) do
    input
    |> compute_md5
  end

  @doc """
    Takes a string and convert it into a list after hashing it using md5

  ## Examples:
      iex> Identicon.main("test")
      [9, 143, 107, 205, 70, 33, 211, 115, 202, 222, 78, 131, 38, 39, 180, 246]
  """
  @spec compute_md5(String) :: String
  def compute_md5(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list
  end



end
