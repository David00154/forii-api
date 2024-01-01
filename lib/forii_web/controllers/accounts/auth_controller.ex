defmodule ForiiWeb.Accounts.AuthController do
  use ForiiWeb, :controller
  import Forii.Dtos

  # alias Forii.A
  # alias Forii.A.Auth

  action_fallback ForiiWeb.FallbackController

  # def index(conn, _params) do
  #   x = A.list_x()
  #   render(conn, :index, x: x)
  # end

  # def create(conn, %{"auth" => auth_params}) do
  #   with {:ok, %Auth{} = auth} <- A.create_auth(auth_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", ~p"/api/accounts/x/#{auth}")
  #     |> render(:show, auth: auth)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   auth = A.get_auth!(id)
  #   render(conn, :show, auth: auth)
  # end

  # def update(conn, %{"id" => id, "auth" => auth_params}) do
  #   auth = A.get_auth!(id)

  #   with {:ok, %Auth{} = auth} <- A.update_auth(auth, auth_params) do
  #     render(conn, :show, auth: auth)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   auth = A.get_auth!(id)

  #   with {:ok, %Auth{}} <- A.delete_auth(auth) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
  def create(conn, params) do
    with {:ok, attrs} <- validate(:create_account_dto, params) do
      conn
      |> put_status(201)
      |> json(attrs)
    end
  end

  def login(conn, params) do
  end

  def verify(conn, params) do
  end

  def refresh(conn, params) do
  end
end
