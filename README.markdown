# Polymorphism, Validations, and Scopes.

## The Setup

Let's say you have a Container model, and that container can have many Parts.

There are many types of Parts (Sprockets, Springs, and Spindles), so we need some polymorphism.

* Containers have_many PartAssignments.
* PartAssignments belong_to a (polymorphic) Part.
* Part is an abstract class, which is used by Sprocket, Spindle, and Spring.

To add a Sprocket to a Container, you'd do something like this:

    c = Container.create(:name => 'Super Container')
    s = Sprocket.new(:name => 'Fancy Sprocket')

    c.part_assignments.create(:part => s)

To add a Spring to the same container, you'd do:

    spring = Spring.new(:name => 'Fancy Spring')

    c.part_assignments.create(:part => spring)

At this point, you can get a list of all the parts:

    c.parts  # => [#<Sprocket id: 1, name: "Fancy Sprocket">, #<Spring id: 1, name: "Fancy Spring">]

And you can get lists of the specific parts:

    c.sprockets  # => [#<Sprocket id: 1, name: "Fancy Sprocket">]
    c.springs  # => [#<Spring id: 1, name: "Fancy Spring">]

All of the above is implemented in this rails app.

## The tricky part

The requirement is: **Parts within the same container must have unique names.**

Given the above models, how do you validate a Part such that it is scoped to its container?  Rails' built-in uniqueness validator lets you set a `:scope => [column_name]`, but that won't work in this case because there is no `container_id` column on our Part model.

My first thought was to have a custom validator on the Part abstract class that fails if `self.container.parts.any?{|p| p.name == self.name }` or something similar. However, at the time the validation is run, the container association doesn't yet exist, so we can't travel back that way.

## Tests

The `test/unit/part_assignment_test.rb` file has several simple tests that demonstrate the desired behavior. One test is failing since I don't know how to implement the needed validation.

Run `rake test` to run the tests.


Any ideas?

# Solutions

* [ryanb](https://github.com/ryanb) suggests moving the validation into PartAssignment instead of Part. See [this branch](https://github.com/johnreilly/polymorphic_validation_scope/tree/ryanb).