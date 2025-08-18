class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.timestamp :last_logged_in_at
      t.string :confirmation_token
      t.text :confirmation_redirect_url
      t.timestamp :confirmed_at
      t.timestamp :confirmation_sent_at
      t.string :reset_password_token
      t.text :reset_password_redirect_url
      t.timestamp :reset_password_sent_at
      t.integer :role, default: 0

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :confirmation_token, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
