class AddDateAndTotalToTxn < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :total, :decimal, precision: 10, scale: 2
    add_column :transactions, :purchase_date, :date
  end
end
