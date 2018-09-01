class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.references :user, foreign_key: true
      t.string :uid
      t.boolean :status, default: true
      t.datetime :last_used_at

      t.timestamps
    end
    add_index :sessions, :uid, unique: true
    add_index :sessions, :status
  end
end
