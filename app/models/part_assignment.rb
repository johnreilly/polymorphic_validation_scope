class PartAssignment < ActiveRecord::Base
  belongs_to :container
  belongs_to :part, :polymorphic => true, :dependent => :destroy

  validates :container, :part, :presence => true
  validates_associated :part
end