defmodule Events do
  @moduledoc """
  Events context
  """
  alias Events.Events.GetByPrettyName
  alias Events.Events.List
  alias Events.Get
  alias Events.Create

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate get_by_pretty_name(pretty_name), to: GetByPrettyName, as: :call
  defdelegate list, to: List, as: :call

  def generate_pretty_name(title) when is_binary(title) do
    generate_pretty_name(%{title: title})
  end

  def generate_pretty_name(%{title: title}) do
    title
    |> String.downcase()
    |> String.replace(" ", "_")
  end
end
