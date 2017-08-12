class CreatePortfolios < ActiveRecord::Migration[5.1]
  def change
    create_table :portfolios do |t|
      t.string :name, null: false
      t.belongs_to :account, index: true, null: false

      t.timestamps
    end
    add_foreign_key :portfolios, :accounts
    
  end
end
