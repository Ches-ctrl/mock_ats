class CreateErrorMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :error_messages, id: :uuid do |t|
      t.integer :status_code
      t.string :message
      t.string :reference
      t.timestamps
    end
  end
end
