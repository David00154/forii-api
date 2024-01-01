defmodule ForiiWeb.Auth.Guardian do
  use Guardian, otp_app: :forii
  alias Forii.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_) do
    {:error, :no_id_provided}
  end

  def authenticate(email, password) do
    case Accounts.get_user_by_email(email) do
      nil ->
        {:error, :unauthorised}

      account ->
        case validate_password(email, password) do
          true -> {}
          false -> {}
        end
    end
  end

  defp validate_password(password, hashed_password) do
    Argon2.verify_pass(password, hashed_password)
  end
end
