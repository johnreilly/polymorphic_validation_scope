class Part < ActiveRecord::Base
  self.abstract_class = true

  has_one :assignment, :as => :part, :class_name => "PartAssignment"
  has_one :container, :through => :assignment

  validates :name, :presence => true

end