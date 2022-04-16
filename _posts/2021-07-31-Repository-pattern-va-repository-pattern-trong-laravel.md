---
title: Repository pattern và repository pattern trong laravel
categories:
- Fullstack
- Backend
- DesignPattern
tags:
- design-pattern
- laravel
---

# Repository pattern
## Khái niệm 
**Design Pattern** là một kỹ thuật trong lập trình hướng đối tượng, nó khá quan trọng và mọi lập trình viên muốn giỏi đều phải biết. Được sử dụng thường xuyên trong các ngôn ngữ OOP. Nó sẽ cung cấp cho bạn các "mẫu thiết kế", giải pháp để giải quyết các vấn đề chung, thường gặp trong lập trình. Các vấn đề mà bạn gặp phải có thể bạn sẽ tự nghĩ ra cách giải quyết nhưng có thể nó chưa phải là tối ưu. Design Pattern giúp bạn giải quyết vấn đề một cách tối ưu nhất, cung cấp cho bạn các giải pháp trong lập trình OOP.

**Repository pattern** là một trong các design pattern, đóng vai trò như một lớp trung gian kết nối giữa tầng business logic và database layer. Điều này sẽ làm bớt việc viết logic tại controller cũng như ở model. 
Những lý do ta nên sử dụng mẫu Repository Pattern:
* Code dễ dàng maintain.
* Tăng tính bảo mật và rõ ràng cho code.
* Lỗi ít hơn.
* tránh việc lặp code.
![My image Name](/assets/img/repository-aggregate-database-table-relationships.png)

Định nghĩa theo sách [Patterns of Enterprise Application Architecture,](https://www.amazon.com/Patterns-Enterprise-Application-Architecture-Martin/dp/0321127420/) Martin Fowler
> A repository performs the tasks of an intermediary between the domain model layers and data mapping, acting in a similar way to a set of domain objects in memory. Client objects declaratively build queries and send them to the repositories for answers. Conceptually, a repository encapsulates a set of objects stored in the database and operations that can be performed on them, providing a way that is closer to the persistence layer. Repositories, also, support the purpose of separating, clearly and in one direction, the dependency between the work domain and the data allocation or mapping.

Thay vì việc viết logic vào trong controller, bạn có thể tạo thư mục Repository và tạo file repository trùng với class model. Sử dụng bằng các inject vào trong controller thông qua construct. 
# Laravel repository pattern

# References 
[Design the infrastructure persistence layer](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/infrastructure-persistence-layer-design#:~:text=The%20Repository%20pattern%20is%20a,working%20with%20a%20data%20source.&text=Conceptually%2C%20a%20repository%20encapsulates%20a,closer%20to%20the%20persistence%20layer.) 

[Tổng hợp các bài hướng dẫn về Design Pattern](https://viblo.asia/p/tong-hop-cac-bai-huong-dan-ve-design-pattern-23-mau-co-ban-cua-gof-3P0lPQPG5ox)
