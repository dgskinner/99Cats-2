class AddUserIdCats < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :integer, presence: true
    add_index :cats, :user_id
    Cat.update_all(["user_id = ?", 1])
  end

end
