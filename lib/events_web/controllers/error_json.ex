defmodule EventsWeb.ErrorJSON do
  @moduledoc """
  This module is invoked by your endpoint in case of errors on JSON requests.

  See config/config.exs.
  """
  alias Ecto.Changeset

  def error(%{message: message}) do
    %{error: message}
  end

  def error(%{changeset: changeset}) do
    %{
      errors: Changeset.traverse_errors(changeset, &translate_errors/1)
    }
  end

  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  defp translate_errors({msg, opts}) do
    Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
      opts
      |> Keyword.get(String.to_existing_atom(key), key)
      |> to_string()
    end)
  end
end
