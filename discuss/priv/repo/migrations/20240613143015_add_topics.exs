defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string
      add :description, :string
    end

    execute "INSERT INTO topics (title, description) VALUES ('Topic 1', 'Description 1')"
    execute "INSERT INTO topics (title, description) VALUES ('Topic 2', 'Description 2')"
  end
end
