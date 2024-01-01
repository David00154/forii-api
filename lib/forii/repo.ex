defmodule Forii.Repo do
  use Ecto.Repo,
    otp_app: :forii,
    adapter: Ecto.Adapters.Postgres
end
