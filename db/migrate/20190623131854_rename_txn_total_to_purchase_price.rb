class RenameTxnTotalToPurchasePrice < ActiveRecord::Migration[5.2]
  def change
    rename_column :transactions, :total, :purchase_price
  end
end
