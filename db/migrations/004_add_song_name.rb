Sequel.migration do
  change do
    add_column :songs, :name, String
  end
end

