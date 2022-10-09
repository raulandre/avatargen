defmodule Avatargen do
  @moduledoc """
  Documentation for `Avatargen`.
  """

  def main(seed) do
    seed
    |> hash
  end

  @doc """
  Generates a md5 hash from a given seed and returns it as a binary list
  """
  def hash(seed) do
    :crypto.hash(:md5, seed)
    |> :binary.bin_to_list
  end
end
