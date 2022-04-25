class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :status_cd, null: false, default: 0
      t.timestamps
    end
  end
end
