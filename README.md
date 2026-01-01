# Low-Level Design (LLD) Practice

A collection of Low-Level Design problems and implementations in Java.
Each module follows clean architecture with domain, service, controller, and repository layers.

## Projects

| Project | Design Patterns | Status |
|---|---|---|
| Parking Lot Problem | Strategy, Factory | ✅ Complete |
| ATM Machine Design | State, Strategy | ✅ Complete |
| Elevator System | Strategy, Observer | ✅ Complete |
| Hotel Management System | Factory, Repository | ✅ Complete |
| Task Management System | Observer, Command | ✅ Complete |
| Logging Framework | Singleton, Chain of Responsibility | ✅ Complete |
| Vending Machine Design | State, Strategy | ✅ Complete |
| Traffic Signal System | State, Observer | ✅ Complete |
| Digital Wallet System | Command, Repository | ✅ Complete |
| Pub-Sub Messaging System | Observer, Mediator | ✅ Complete |

## Architecture

Each project follows clean layered architecture:

```
project/
├── domain/         # Entities, Enums, Exceptions, Value Objects
├── repository/     # Storage interfaces + in-memory implementations
├── service/        # Business logic and use cases
├── controller/     # Orchestration layer
└── main/           # Demo / simulation entry point
```

## Design Patterns Covered

- **State Pattern** – ATM Machine, Vending Machine, Traffic Signal
- **Strategy Pattern** – ATM Transactions, Parking Fee Calculation, Elevator Scheduling
- **Observer Pattern** – Task Notifications, Pub-Sub System
- **Singleton Pattern** – Logging Framework
- **Factory Pattern** – Hotel Room creation, Vehicle types
- **Chain of Responsibility** – Log filter chain
- **Command Pattern** – Task Management, Digital Wallet operations
- **Repository Pattern** – All projects (data abstraction)

## Tech Stack

- Java 17
- Object-Oriented Design Principles (SOLID)
- No external frameworks – pure Java implementations
