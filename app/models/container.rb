class Container < ActiveRecord::Base
  has_many :part_assignments, :dependent => :destroy

  has_many :sprockets, :through => :part_assignments, :source => :part, :source_type => 'Sprocket'
  has_many :springs, :through => :part_assignments, :source => :part, :source_type => 'Spring'
  has_many :spindles, :through => :part_assignments, :source => :part, :source_type => 'Spindle'

  def parts
    sprockets + springs + spindles
  end
end