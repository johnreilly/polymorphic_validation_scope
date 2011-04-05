class CreateSprings < ActiveRecord::Migration
  def self.up
    create_table :springs do |t|
      t.text :name
    end
  end

  def self.down
    drop_table :springs
  end
end
