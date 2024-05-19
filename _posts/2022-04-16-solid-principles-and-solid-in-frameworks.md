---
title: SOLID principles, and SOLID in frameworks (part 1)
categories:
- Blogging
- Tutorial
tags:
- solid
- rails
- laravel
- PHP
- ruby
- python
---

Solid principles contains five best praticles when construct source code by OOP methodology.

![Solid priciples](/assets/img/solid-priciples/solid.png)


## Single responsible principles
The single-responsibility principle (SRP) is a computer-programming principle that states that every module, class or function in a computer program should have responsibility over a single part of that program's functionality, and it should encapsulate that part. All of that module, class or function's services should be narrowly aligned with that responsibility.
E.g: 
Defime module **User** manage user, define **User** class represent **User** in system, define **Role** class manage **Role** in System, define **Permission** class represent **Permission** in system, **Policy** class represent **policy** in system.
> Every software component should have one and only one reponsiblity reason to change.

![Sigle reponsiblities](/assets/img/solid-priciples/sinple-reponsibility.png)

### cohesion
> Cohesion is the degree to which the various part of a software components related

Higher cohesion helps attain better adherence  to the SRP.
![Sigle reponsiblities: Cohesion](/assets/img/solid-priciples/cohesion-srp.png){: .shadow }
### coupling
> Coupling is defined as level of the inter dependency  betweens various of software components.

Loose coupling helps attain better adherence  to the SRP.

![Sigle reponsiblities: loose coupling](/assets/img/solid-priciples/loose-coupling.png){: .shadow }

```php

class Rectangle {
  
    public $width;
    public $height;
    
    public function __construct($width, $height) {
        $this->width = $width;
        $this->height = $height;
    }
}

class Square {
  
    public $length;
    
    public function __construct($length) {
        $this->length = $length;
    }
}


class AreaCalculator {
  
    protected $shapes;
    
    public function __construct($shapes = array()) {
        $this->shapes = $shapes;
    }
    
    public function sum() {
        $area = [];
        
        foreach($this->shapes as $shape) {
            if($shape instanceof Square) {
                $area[] = pow($shape->length, 2);
            } else if($shape instanceof Rectangle) {
                $area[] = $shape->width * $shape->height;
            }
        }
    
        return array_sum($area);
    }
}

```
## Open closed princliple
> Software components should be closed for modification, but open for extension 
![Open closed principle](/assets/img/solid-priciples/open-closed-principle.png){:.shadow }

1. Closed for modification: New features getting added to sofrware component, should not have modify code
2. Open for extensiion: A software should be extenable to add a new feature or to add a new behaviour to it.
Eg: Define two class of Shape with attributes is closed for moification and the method is open for extendsion, example like we want calculator for area of rectangle.

```php
interface Shape
{
    /**
     * Calculate the area of the shape.
     *
     * @return mixed
     */
    public function getArea();
}

class Rectangle implements Shape
{
    private $width;
    private $height;

    public function getArea()
    {
        return $this->width * $this->height;
    }
}

class Circle implements Shape
{
    private $radius;

    private function getArea()
    {
        return pow($this->radius, 2) * PI;
    }
}

/**
     * Calculate the total area of the shapes.
     *
     * @param  Illuminate\Support\Collection  $shapes
     * @return float
     */
    public function Area($shapes)
    {
        $area = 0;
        $shapes->each(function ($shape) use (&$area) {
           $area += $shape->getArea();
        });
        return $area;
    }
}
```
Good:
- Ease of adding new features
- Lead to minimal cost of developing and testing software
- requires decoupling, which in turn automatically foallows the **SRP**

Caution:
- Do not bindly, you will end up with a huge number of class that can complicated your overall design. 
- Make a subjective, rather than an objective decision.
**The Open/Closed Principle is designed to make you write your code in such a manner that the core functionality is as unambiguous and concise as possible**

## Liskov subtitution priciple
> Obejct should be replaceable with their subtypes without affecting the correctness of the program

![Liskov subtitution principle]({{ '/assets/img/solid-priciples/liskov subtitution principle.png' | relative_url }}){: .shadow }

```php
abstract class Bird 
{
		abstract public function fly();
}

class Pengiue extends Bird {
	public function fly() 
	{
			return false;
	}
}

class Eagle extends Bird {

	public function fly()
	{
			return true
	}
}
```
- break the hierachy
- Tell, don't ask

## Interface Segregation principle
> No client should be forced to depend on methods it does not use

![]({{ 'assets/img/solid-priciples/interface segregation principle.png' | relative_url }})

Techniques to identify violations of ISP
1. Fat interfaces.
2. Interface with low cohesion.
3. Empty method implentations.

```php
<?php

// Interface Segregation Principle Violation
interface Workable
{
    public function canCode();
    public function code();
    public function test();
}

class Programmer implements Workable
{
    public function canCode()
    {
        return true;
    }

    public function code()
    {
        return 'coding';
    }

    public function test()
    {
        return 'testing in localhost';
    }
}

class Tester implements Workable
{
    public function canCode()
    {
        return false;
    }

    public function code()
    {
         throw new Exception('Opps! I can not code');
    }

    public function test()
    {
        return 'testing in test server';
    }
}

class ProjectManagement
{
    public function processCode(Workable $member)
    {
        if ($member->canCode()) {
            $member->code();
        }
    }
}

// Refactored
interface Codeable
{
    public function code();
}

interface Testable
{
    public function test();
}

class Programmer implements Codeable, Testable
{
    public function code()
    {
        return 'coding';
    }

    public function test()
    {
        return 'testing in localhost';
    }
}

class Tester implements Testable
{
    public function test()
    {
        return 'testing in test server';
    }
}

class ProjectManagement
{
    public function processCode(Codeable $member)
    {
        $member->code();
    }
}

```

## Dependentcy Injection principle
> High level module should not depend on low level module, Both should depend on abstrctions.
![]({{ 'assets/img/solid-priciples/DI.png' | relative_url }})
> Abstraction should not depend on details. Details should depend on abstraction 
![]({{ 'assets/img/solid-priciples/DI example.png' | relative_url }})
### Without dependency injection

```php
class GoogleMaps
{
    public function getCoordinatesFromAddress($address) {
        // calls Google Maps webservice
    }
}

class OpenStreetMap
{
    public function getCoordinatesFromAddress($address) {
        // calls OpenStreetMap webservice
    }
}

class StoreService
{
    public function getStoreCoordinates($store) {
        $geolocationService = new GoogleMaps();
        // or $geolocationService = GoogleMaps::getInstance() if you use singletons

        return $geolocationService->getCoordinatesFromAddress($store->getAddress());
    }
}
```
### With dependency injection

```php
class StoreService {
    private $geolocationService;

    public function __construct(GeolocationService $geolocationService) {
        $this->geolocationService = $geolocationService;
    }

    public function getStoreCoordinates($store) {
        return $this->geolocationService->getCoordinatesFromAddress($store->getAddress());
    }
}

interface GeolocationService {
    public function getCoordinatesFromAddress($address);
}

class GoogleMaps implements GeolocationService { ...

class OpenStreetMap implements GeolocationService { ...
```
### Inversion of control
> Inversion of control (IOC) defines the way objects are used, but it does not specify how to create them. IOC defines the relationship between the high-level class and detail class, where the high-level class depends on detail class. High- and low-level classes are related by abstracting a detail class in IOC.

```php
<?php
//Define ClassA
class ClassA
{
    public $ClassB;
    public $ClassC;
    public function ClassA()
    {
        echo "<h2 style='color:red'> Initialization of ClassA </h2>";
    }
    public function method()
    {
        $this->ClassB = new ClassB();
        $this->ClassC = new ClassC();
        $this->ClassB->method();
        $this->ClassC->method();
    }
}

//Define ClassB
class ClassB
{
    public function ClassB()
    {
        echo "<h2 style='color:blue'> Initialization of ClassB </h2>";
    }
    public function method()
    {
        echo "<h3 style='color:blue'> The output from ClassB </h3>";
    }
}

//Define ClassC
class ClassC
{
    public function ClassC()
    {
        echo "<h2 style='color:green'> Initialization of ClassC </h2>";
    }
    public function method()
    {
        echo "<h3 style='color:green'> The output from ClassC </h3>";
    }
}

//Create object of ClassA
$object = new ClassA();
//Call the method() function
$object->method();
?>
```
## Totally
> SOLID principles complement each other, and work together in unison, to achieve the common purpose of well-designed software
