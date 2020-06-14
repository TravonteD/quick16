Sequel.migration do
  change do
    create_table(:songs) do
      primary_key :id
    end
    alter_table(:verses) do
      add_foreign_key :song_id, :songs
    end
  end
end
