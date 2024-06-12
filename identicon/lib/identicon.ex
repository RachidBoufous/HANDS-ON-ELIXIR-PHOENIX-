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
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end


  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)

  end

  def save_image(image, filename) do
    File.write("#{filename}.png", image)
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    # going to iterate over all the element on the gird so for each element we create two coordinates / points for each square
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end
    %Identicon.Image{image | pixel_map: pixel_map}
  end


  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _}) ->
      rem(code,2) == 0
    end

    %Identicon.Image{image | grid: grid}
  end


  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
    hex
        |> Enum.chunk(3)
        |> Enum.map(&mirror_row/1) # we are invoking only the mirror row func with 1 param
        # for every row we have please run mirror row function.
        |> List.flatten # this will take all the nested list and will flatten them into a single index
        |> Enum.with_index # here we going to take each element in the list convert it into a tuple that has the index + the number { element, index}
    %Identicon.Image{image | grid: grid } # update the image struct with the grid.
  end

  def mirror_row(row) do
    [first, second | _tail] = row # get the first the second but thhe rest just leave it in tail
    row ++ [second, first] # append new list to the other list list concatination
  end

  @doc """
    Takes an Image structure and return list of RGB value based on the first three values in our hex list
  ## Examples:
        iex> Identicon.main("test")
        %Identicon.Image{
          color: {9, 143, 107},
          hex: [9, 143, 107, 205, 70, 33, 211, 115, 202, 222, 78, 131, 38, 39, 180, 246]
        }
  """
  @spec pick_color(String) :: List
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    # we can move our pattern matching to the arg list. elixir allows you to do so
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
