defmodule Biblex do
  alias Biblex.Book
  import Ecto.Changeset, only: [apply_action: 2, traverse_errors: 2]

  def create_book(params) do
    params
    |> Book.changeset()
    |> apply_action(:create)
    |> handle_create()
  end

  defp  handle_create({:ok, book}), do: %{status: :ok, result: book}
  defp  handle_create({:error, changeset}) do
    %{status: :bad_request, result: translate_errors(changeset)}
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end

# %{title: "Lord of the rings", author: "Tolkien", isbn: "9786589999013", price: "27.25"}
# Biblex.create_book(%{title: "Lord of the rings", author: "Tolkien", isbn: "9786589999013", price: "27.25"})
