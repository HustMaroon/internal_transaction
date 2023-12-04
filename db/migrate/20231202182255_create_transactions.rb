class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|

      t.bigint :source_id, null: true
      t.string :source_type, null: true
      t.bigint :target_id, null: true
      t.string :target_type, null: true
      t.decimal :amount, precision: 30, scale: 18, null: false
      t.string :currency, null: false
      t.string :transaction_type, null: false
      t.timestamps
    end

    add_index :transactions, %i[source_id source_type currency]
    add_index :transactions, %i[target_id target_type currency]
  end
end
