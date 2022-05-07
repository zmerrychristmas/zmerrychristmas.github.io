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
