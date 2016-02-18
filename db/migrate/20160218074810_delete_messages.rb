class DeleteMessages < ActiveRecord::Migration
  def up
    drop_table :messages
    drop_table :conversations
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
  end
