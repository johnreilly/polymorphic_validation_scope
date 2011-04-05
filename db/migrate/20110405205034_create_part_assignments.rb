class CreatePartAssignments < ActiveRecord::Migration
  def self.up
    create_table :part_assignments do |t|
      t.references :container
      t.references :part, :polymorphic => true
    end
  end

  def self.down
    drop_table :spindles
  end
end
