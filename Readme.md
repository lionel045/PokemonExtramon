# SwiftUI Pokedex

## Introduction
Welcome to my SwiftUI Pokedex project! This is my first attempt at using SwiftUI along with the MVVM design pattern and Clean Architecture principles. The goal of this project was to build a Pokedex application that adheres to the principles of MVVM for handling the user interface logic and Clean Architecture for structuring the overall codebase.

![Screen1](https://github.com/lionel045/PokemonExtramon/blob/main/Screen1.png)
![Screen2](https://github.com/lionel045/PokemonExtramon/blob/main/Screen2.png)

## Project Overview
This Pokedex app is designed using SwiftUI and follows a robust architecture to ensure that the code is modular, reusable, and maintainable. The architecture is divided into several layers, each with a specific role and responsibility.

### Clean Architecture Layers

#### 1. Presentation Layer
- **Role**: Handles all UI-related processes.
- **Components**: Views and ViewModels.
- **Details**: Utilizes SwiftUI for the views and leverages the MVVM pattern to bind these views with their respective ViewModels. The design is responsive and adapts to any iPhone screen size, ensuring a consistent user experience across all devices.

#### 2. Domain Layer
- **Role**: Defines the core business logic and rules.
- **Components**: Use Cases, Models, and Repository Interfaces.
- **Details**: This layer is independent of other layers, ensuring that the business logic can be understood and modified without external influences.

#### 3. Data Layer
- **Role**: Manages data transactions and transformations.
- **Components**: Repositories, Data Sources (Remote and Local).
- **Details**: Repositories implement the interfaces defined in the domain layer, and interact with various data sources to fetch, store, and manage application data.

### Architectural Benefits
- **Decoupling**: Each layer operates independently of the others, which reduces dependencies and makes the system easier to manage and modify.
- **Reusability**: Modular design allows for reusing components in different parts of the application or in different projects.
- **Testability**: Separation of concerns makes it easier to test the application at different levels (e.g., unit testing, integration testing).

## Roadmap
Moving forward, the development of this Pokedex app will focus on the following key enhancements:

- **UI Improvements**: Enhance the user interface to be more visually appealing and intuitive. This includes refining layouts and adding more interactive elements.
- **Menu Implementation**: Introduce a dynamic menu system to provide more navigation options and improve user interaction.
- **Unit Testing**: Develop a comprehensive suite of unit tests to ensure the reliability and performance of the application. This will involve testing all critical components of the MVVM and Clean Architecture layers to validate their functionality under various conditions.


