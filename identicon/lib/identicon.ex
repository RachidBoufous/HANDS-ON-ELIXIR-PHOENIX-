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
    |> pick_color()
  end

  @doc """
    Takes an Image structure and return list of RGB value based on the first three values in our hex list
  ## Examples:
        iex> Identicon.main("test")
        [9, 143, 107]
  """
  @spec pick_color(String) :: List
  def pick_color(image) do
   %Identicon.Image{hex: [r, g, b | _tail]} = image

   # updating a the image by adding rgb value
   %Identicon.Image{image | color: {r,g,b}} # we don't update existing data but we create new record
   # here we are updating the map telling it to keep everything we have in image but update the color


  end

  @doc """
    Takes a string and convert it into a list after hashing it using md5

  ## Examples:
      iex> Identicon.main("test")
      %Identicon.Image{
        hex: [9, 143, 107, 205, 70, 33, 211, 115, 202, 222, 78, 131, 38, 39, 180, 246]
      }
  """
  @spec compute_md5(String) :: String
  def compute_md5(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end



end
