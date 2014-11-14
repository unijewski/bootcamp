class CreateFacebookAccounts < ActiveRecord::Migration
  def change
    create_table :facebook_accounts do |t|
      t.string :uid
      t.integer :person_id

      t.timestamps
    end
  end
end
