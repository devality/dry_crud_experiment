class AddStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :name, unique: true, null: false
      t.string :state, null: false
      t.references :bearer, foreign_key: true

      t.timestamps
    end
  end
end
