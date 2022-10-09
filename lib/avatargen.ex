defmodule Avatargen do
  @moduledoc """
  Documentation for `Avatargen`.
  """

  def main(seed) do
    seed
    |> hash
    |> get_colors
    |> gen_grid
    |> filter_odd_squares
  end

  def filter_odd_squares(%Avatargen.Image{ grid: grid } = image) do
    grid = Enum.filter(grid, fn({idx, _}) -> rem(idx, 2) == 0 end)

    %Avatargen.Image{
      image | grid: grid
    }
  end

  def gen_grid(%Avatargen.Image{ hex: hex } = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Avatargen.Image{
      image | grid: grid
    }
  end

  def mirror_row(row) do
    [first, second | _] = row
    row ++ [second, first]
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
  def get_colors(%Avatargen.Image{ hex: [r, g, b | _] } = image) do
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
