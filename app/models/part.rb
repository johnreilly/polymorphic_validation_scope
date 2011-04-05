class Part < ActiveRecord::Base
  self.abstract_class = true

  has_one :assignment, :as => :part, :class_name => "PartAssignment"
  has_one :container, :through => :assignment

  validates :name, :presence => true

  validate :verify_unique_name

  private
  def verify_unique_name
    ### What should go here in order to validate that all Parts
    ### in a Container should have unique names?
  end
end