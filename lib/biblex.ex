defmodule Biblex do
  alias Biblex.Book
  import Ecto.Changeset, only: [apply_action: 2]

  def create_book(params) do
    params
    |> Book.changeset()
    |> apply_action(:create)
  end
end
