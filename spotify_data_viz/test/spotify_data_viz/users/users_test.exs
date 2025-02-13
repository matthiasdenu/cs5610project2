defmodule SpotifyDataViz.UsersTest do
  use SpotifyDataViz.DataCase

  alias SpotifyDataViz.Users

  describe "users" do
    alias SpotifyDataViz.Users.User

    @valid_attrs %{access_token: "some access_token", refresh_token: "some refresh_token", timestamp: "2010-04-17 14:00:00.000000Z", user_id: "some user_id"}
    @update_attrs %{access_token: "some updated access_token", refresh_token: "some updated refresh_token", timestamp: "2011-05-18 15:01:01.000000Z", user_id: "some updated user_id"}
    @invalid_attrs %{access_token: nil, refresh_token: nil, timestamp: nil, user_id: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.access_token == "some access_token"
      assert user.refresh_token == "some refresh_token"
      assert user.timestamp == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert user.user_id == "some user_id"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Users.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.access_token == "some updated access_token"
      assert user.refresh_token == "some updated refresh_token"
      assert user.timestamp == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert user.user_id == "some updated user_id"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
