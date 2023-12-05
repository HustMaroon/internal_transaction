class AddLastTxTimestampToTransferable < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_tx_timestamp, :datetime
    add_column :teams, :last_tx_timestamp, :datetime
    add_column :stocks, :last_tx_timestamp, :datetime
  end
end
