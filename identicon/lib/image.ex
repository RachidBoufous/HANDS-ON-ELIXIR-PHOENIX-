defmodule Identicon.Image do
   @moduledoc """
      will represent all the information about generated images like it's hex code, color.
  """

  defstruct hex: nil, color: nil, grid: nil, pixel_map: nil
end
