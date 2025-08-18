class CreateBorrowings < ActiveRecord::Migration[8.0]
  def change
    create_table :borrowings do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.datetime :borrowed_at
      t.datetime :due_date
      t.datetime :returned_at

      t.timestamps
    end

    add_index :borrowings, [ :user_id, :book_id, :returned_at ], unique: true, name: "unique_borrowing"
  end
end
