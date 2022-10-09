defmodule Avatargen do
  @moduledoc """
  Documentation for `Avatargen`.
  """

  def main(seed) do
    seed
    |> hash
    |> get_colors
  end

  @doc """
  Returns a new Avatargen.Image containing the RGB values

  ## Examples:
    iex> image = Avatargen.hash("avatargen")
    iex> Avatargen.get_colors(image)
    %Avatargen.Image{
      hex: [222, 51, 125, 87, 30, 108, 250, 77, 85, 28, 162, 229, 155, 62, 226, 227],
      rgb: {222, 51, 125}
    }
  """
  def get_colors(image) do
    [r, g, b | _] = image.hex

    %Avatargen.Image{
      image | rgb: {r, g, b}
    }
  end

  @doc """
  Generates a md5 hash from a given seed and returns an Avatargen.Image

  ## Examples:
    iex> Avatargen.hash("avatargen")
    %Avatargen.Image{
      hex: [222, 51, 125, 87, 30, 108, 250, 77, 85, 28, 162, 229, 155, 62, 226, 227]
    }
  """
  def hash(seed) do
    hex = :crypto.hash(:md5, seed)
    |> :binary.bin_to_list

    %Avatargen.Image{hex: hex}
  end
end
