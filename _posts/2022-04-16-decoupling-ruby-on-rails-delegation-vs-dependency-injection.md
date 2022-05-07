---
title: 'Decoupling Ruby on Rails: Delegation vs Dependency Injection'
categories:
- Fullstack
- Backend
tags:
- ruby
- solid
- dependency
- rails
- oop
---

# Delegation && Dependency Injection
## Delegation 
Ruby’s standard library provides us SimpleDelegator as an easy way to implement the decorator pattern. You pass in your object to the constructor, and then any method calls to the delegator are forwarded to your object.
E.g:
```ruby
class PrawnWrapper < SimpleDelegator
  def initialize(document: nil)
    document ||= Prawn::Document.new(...)
    super(document)
  end
end
```
We can then update our reports to inherit from this class, and they will still function the same as before, using the default document created in our initializer. The magic happens when we use this in our overview report:
```ruby
class OverviewReport < PrawnWrapper
  ...
  def render
    sales = SaleReport.new(..., document: self)
    sales.sales_table
    costs = CostReport.new(..., document: self)
    costs.costs_pie_chart
    ...
  end
end
```
 we have essentially made it as if SalesReport is now a subclass of OverviewReport. In our case, this means that all the calls to prawn’s API now go `SalesReport -> OverviewReport -> Prawn::Document`.
### How SimpleDelegator Works: deletegation as services
The way SimpleDelegator works under the hood is basically to use Ruby's `method_missing` functionality to forward method calls to another object.

So SimpleDelegator (or a subclass of it) receives a method call. If it implements that method, great; it will execute it just as any other object would. However, it if does not have that method defined, then it will hit method_missing. method_missing will then attempt to call that method on the object given to its constructor.
```rb
require 'simple_delegator'
class Thing
  def one
    'one'
  end
  def two
    'two'
  end
end

class ThingDecorator < SimpleDelegator
  def two
    'three!'
  end
end

ThingDecorator.new(Thing.new).one #=> "one"
ThingDecorator.new(Thing.new).two #=> "three!"
```
>  The key difference: SimpleDelegator takes the object **it will delegate to as an argument in its constructor**. This means we can pass in different objects at runtime.

This is what allows use to redirect the calls to a prawn object in Solution 2 above. If we call a single report, the prawn calls go to a new document created in the constructor. The overview report, however, can change this so that calls to prawn are forwarded to its document.
### Delegate in Active Record
Forward methods or attributes from class to subclass 
```rb
class Greeter < ActiveRecord::Base
  def hello
    'hello'
  end

  def goodbye
    'goodbye'
  end
end

class Foo < ActiveRecord::Base
  belongs_to :greeter
  delegate :hello, to: :greeter
end

Foo.new.hello   # => "hello"
Foo.new.goodbye # => NoMethodError: undefined method `goodbye' for #<Foo:0x1af30c>
```
## Dependency Injection(DI)
### Concept 
In software engineering, dependency injection is a design pattern in which an object receives other objects that it depends on. A form of inversion of control, dependency injection aims to separate the concerns of constructing objects and using them, leading to loosely coupled programs.[1][2][3] The pattern ensures that an object which wants to use a given service should not have to know how to construct those services. Instead, the receiving object (or 'client') is provided with its dependencies by external code (an 'injector'), which it is not aware of.[4] Dependency injection solves the following problems:[5]

1. How can a class be independent from the creation of the objects it depends on?
2. How can an application, and the objects it uses support different configurations?
3. How can the behavior of a piece of code be changed without editing it directly?
4. Fundamentally, dependency injection consists of passing parameters to a method.
5. As mentioned previously, one common solution to this kind of problem is to refactor the code to use Dependency Injection. That is, rather than having all these reports call methods on self, we will instead pass in our PDF document as an argument.

### Dependency injection in services
This would give us something more like:
```rb
class CostReport < Prawn::Document
...
  def title(pdf = self)
    pdf.text "Cost Report"
    pdf.move_down 20
    ...
  end
end
```
This works, but there is some overhead here. For one thing, every single drawing method now has to take the pdf argument, and every single call to prawn now has to go through this pdf argument.

Dependency injection has some benefits: it pushes us toward **decoupled components** in our system and allows us to pass in mocks or stubs to make unit testing easier.

However, we are not reaping the rewards of these benefits in our scenario. We are already strongly coupled to the prawn API, so `changing to a different PDF library` would almost certainly require an entire rewrite of the code.

Testing is also not a big concern here, because in our case testing generated PDF reports with automated tests is too cumbersome to be worthwhile.

## Delegation and Dependency Injection 
I want to mention, when Developer need to implement Dependency Injection in Rails is make something double and couple because It's likely we want to create multiple services different and less couple with base class used While Ruby on Rails is every where we can fine or define an Object and we spent manage effort with each class services.
So it less use than delegation.
Let think about a Document class want to define a method to render a report. By DI we mush define a method with parameter is Interface represent of class handling services.
But in delegate we make a less couple but still maintain connection between two class, by passing a method from other class to use in this class. This behavious is same but one is Rails define and support, one is design pattern so we can choose to use an approach with each use case.

Use Case when DI is always better: Declare services with long time developement but need behavious we wanted, So we can boot a class use DI when bootstrap a service so give a best performance while delegate is must require the clarify of other class method and this required a check behavious: input and output before using delegate.
