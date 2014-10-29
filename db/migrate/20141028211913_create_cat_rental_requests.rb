class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.integer :cat_id, null: false, index: true
      t.string :status, null:false, default: "PENDING"
      t.date :start_date, null: false
      t.date :end_date, null: false
   
      t.timestamps
    end
  end
end
