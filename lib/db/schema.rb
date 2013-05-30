Sequel.migration do
  change do
    create_table(:schema_migrations) do
      String :filename, :text=>true, :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:users, :ignore_index_errors=>true) do
      primary_key :id
      String :state, :text=>true, :null=>false
      String :email, :text=>true, :null=>false
      String :encrypted_password, :text=>true, :null=>false
      DateTime :created_at, :null=>false
      DateTime :updated_at, :null=>false
      
      index [:email], :name=>:users_email_key, :unique=>true
    end
  end
end
