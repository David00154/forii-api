defmodule Forii.Dtos do
  use Goal

  defparams :create_account_dto do
    required(:email, :string, format: :email)
    required(:password, :string, trim: true)
    required(:username, :string, trim: true)
  end
end
