class PartAssignment < ActiveRecord::Base
  belongs_to :container
  belongs_to :part, :polymorphic => true, :dependent => :destroy

  validates :container, :part, :presence => true
  validates_associated :part
  validate :ensure_unique_part_name

  private
  def ensure_unique_part_name
    if container.parts.any? {|p| p.name == part.name }
      errors.add :part, "cannot be added to container since another part exists with the same name."
    end
  end
end