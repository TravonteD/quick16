Sequel.migration do
  change do
    create_table(:verses) do
      primary_key :id
    end
    alter_table(:bars) do
      add_foreign_key :verse_id, :verses
    end
  end
end
