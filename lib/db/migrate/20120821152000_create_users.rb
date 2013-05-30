Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      String :state, null: false
      String :email, unique: true, null: false
      String :encrypted_password, null: false

      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end