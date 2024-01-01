defmodule ForiiWeb.Accounts.AuthControllerTest do
  use ForiiWeb.ConnCase

  import Forii.AFixtures

  alias Forii.A.Auth

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all x", %{conn: conn} do
      conn = get(conn, ~p"/api/accounts/x")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create auth" do
    test "renders auth when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts/x", auth: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/accounts/x/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts/x", auth: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update auth" do
    setup [:create_auth]

    test "renders auth when data is valid", %{conn: conn, auth: %Auth{id: id} = auth} do
      conn = put(conn, ~p"/api/accounts/x/#{auth}", auth: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/accounts/x/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, auth: auth} do
      conn = put(conn, ~p"/api/accounts/x/#{auth}", auth: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete auth" do
    setup [:create_auth]

    test "deletes chosen auth", %{conn: conn, auth: auth} do
      conn = delete(conn, ~p"/api/accounts/x/#{auth}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/accounts/x/#{auth}")
      end
    end
  end

  defp create_auth(_) do
    auth = auth_fixture()
    %{auth: auth}
  end
end
