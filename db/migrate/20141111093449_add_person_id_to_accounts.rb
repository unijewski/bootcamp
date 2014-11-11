class AddPersonIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :person_id, :string
  end
end
