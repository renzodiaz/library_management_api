class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :genre
      t.string :isbn
      t.integer :total_copies
      t.references :author, foreign_key: true

      t.timestamps
    end

    add_index :books, :title
    add_index :books, :genre
    add_index :books, :isbn, unique: true
  end
end
