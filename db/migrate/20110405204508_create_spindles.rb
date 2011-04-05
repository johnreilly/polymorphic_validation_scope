class CreateSpindles < ActiveRecord::Migration
  def self.up
    create_table :spindles do |t|
      t.text :name
    end
  end

  def self.down
    drop_table :spindles
  end
end
