# Solution from ryanb

Ryan Bates ([ryanb](https://github.com/ryanb)) suggests moving the validation from the Part model to the PartAssignment model:

> However I don't think the validation should be added to the Part model. The part in itself is fully valid because there can be parts with the same name. What's invalid is the PartAssignment because that cannot join a part to a container when a part has the same name.

See: [GH-Issue #1](https://github.com/johnreilly/polymorphic_validation_scope/issues/#issue/1)

I've applied his suggested changes, and the tests now pass.

Thank you Ryan!