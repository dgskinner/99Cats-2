class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, presence: true
      t.string :password_digest, presence: true
      t.string :session_token, presence: true

      t.timestamps
    end
    add_index :users, :session_token, unique: true
    add_index :users, :user_name, unique: true
  end
end
