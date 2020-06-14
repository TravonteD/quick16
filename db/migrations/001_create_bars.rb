Sequel.migration do
  change do
    create_table(:bars) do
      primary_key :id
      String :text, null: false, default: ''
    end
  end
end
