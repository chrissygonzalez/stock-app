class AddOpenPriceToStocks < ActiveRecord::Migration[5.2]
  def change
    change_column :stocks, :price, :decimal, precision: 10, scale: 2
    add_column :stocks, :open_price, :decimal, precision: 10, scale: 2
  end
end
