class CreateSprockets < ActiveRecord::Migration
  def self.up
    create_table :sprockets do |t|
      t.text :name
    end
  end

  def self.down
    drop_table :sprockets
  end
end
