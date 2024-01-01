defmodule ForiiWeb.FallbackController do
  import Goal

  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ForiiWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: ForiiWeb.ErrorHTML, json: ForiiWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    error = recase_keys(%{errors: Goal.Changeset.traverse_errors(changeset, &translate_error/1)})

    conn
    |> put_status(406)
    |> json(error)
  end

  defp translate_error({msg, opts}) do
    Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
      opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
    end)
  end
end
