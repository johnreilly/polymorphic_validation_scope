require 'test_helper'

class PartAssignmentTest < ActiveSupport::TestCase

  test "Adding a part (Sprocket) to a Container" do
    container = Container.create(:name => 'Happy Container')
    part      = Sprocket.new(:name => "happy sprocket")

    # Add the part to the container
    container.part_assignments.create!(:part => part)
    container.reload

    # Verify it's there
    assert_equal 1, container.parts.count
    assert_equal part, container.parts.first
  end

  test "Adding several parts (of different types) to a Container" do
    container     = Container.create(:name => 'Happy Container')
    sprocket_part = Sprocket.new(:name => "happy sprocket")
    spring_part   = Spring.new(:name => "happy spring")
    spindle_part  = Spindle.new(:name => "happy spindle")

    # Add the different parts
    container.part_assignments.create!(:part => sprocket_part)
    container.part_assignments.create!(:part => spring_part)
    container.part_assignments.create!(:part => spindle_part)
    container.reload

    # Make sure all the parts exist in the container
    assert_equal 3, container.parts.count
    assert container.parts.include?(sprocket_part)
    assert container.parts.include?(spring_part)
    assert container.parts.include?(spindle_part)
  end

  test "Fetching parts out of a container by type" do
    container     = Container.create(:name => 'Happy Container')
    sprocket_part = Sprocket.new(:name => "happy sprocket")
    spring_part   = Spring.new(:name => "happy spring")
    spindle_part  = Spindle.new(:name => "happy spindle")

    # Add the different parts
    container.part_assignments.create!(:part => sprocket_part)
    container.part_assignments.create!(:part => spring_part)
    container.part_assignments.create!(:part => spindle_part)
    container.reload

    # Make sure all the parts exist in the container by type
    assert_equal 1, container.sprockets.count
    assert container.sprockets.include?(sprocket_part)

    assert_equal 1, container.springs.count
    assert container.springs.include?(spring_part)

    assert_equal 1, container.spindles.count
    assert container.spindles.include?(spindle_part)
  end

  test "Adding an invalid part shouldn't save the part" do
    container = Container.create(:name => 'Happy Container')
    part      = Sprocket.new(:name => nil) #invalid!

    # Add the part to the container
    assignment = container.part_assignments.create(:part => part)
    container.reload

    # Verify the part is NOT in the container
    assert_equal 0, container.parts.count

    # The assignment should be invalid because the part was invalid.
    assert !assignment.valid?
    assert assignment.errors.include?(:part)

    # Part was invalid because name was blank.
    assert part.errors.include?(:name)
  end


  ###
  ### => Here's the tricky part!
  ###

  test "A container's parts should have unique names within the container" do
    container     = Container.create(:name => 'Happy Container')
    sprocket_part = Sprocket.new(:name => "happy part")
    spring_part   = Spring.new(:name => "happy part")

    # Add the parts
    good_assignment = container.part_assignments.create(:part => sprocket_part)
    bad_assignment  = container.part_assignments.create(:part => spring_part)
    container.reload

    # The first assignment should work, the second should fail becuase it has the same name as the first.
    assert good_assignment.valid?
    assert !bad_assignment.valid?, "bad assignment expected to be invalid, but wasn't!"

    assert spring_part.errors.include?(:name) # should be unique

    assert_equal 1, container.parts.count
  end

  test "Parts in different containers are OK to have the same name" do
    container1    = Container.create(:name => 'Happy Container 1')
    container2    = Container.create(:name => 'Happy Container 2')
    sprocket_part = Sprocket.new(:name => "happy part")
    spring_part   = Spring.new(:name => "happy part")

    # Add the parts
    container1.part_assignments.create(:part => sprocket_part)
    container2.part_assignments.create(:part => spring_part)
    container1.reload
    container2.reload

    # Both assignments should be OK
    assert sprocket_part.valid?
    assert spring_part.valid?

    assert_equal 1, container1.parts.count
    assert_equal 1, container2.parts.count
  end
end
