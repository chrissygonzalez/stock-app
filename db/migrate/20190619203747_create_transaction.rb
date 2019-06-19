class CreateTransaction < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :quantity
      t.integer :user_id
      t.integer :stock_id
    end
  end
end
