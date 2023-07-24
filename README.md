# cloudwalk_weather

Current flutter version of the project 3.10.5 

This is a Flutter sample app that demonstrates the use of Clean Architecture with Bloc pattern and an abstraction layer for the Dio package. The app follows best practices to achieve a separation of concerns, making it easier to maintain, test, and extend.

## Overview

The app is a weather forecast application that allows users to view the current weather conditions and forecast for various cities. It fetches weather data from an external API using the Dio package and follows Clean Architecture principles to organize the codebase into different layers.

## Features

View the current weather conditions for multiple cities
Fetch the weather forecast for multiple cities
Allow filtering of the cities

## Clean Architecture Layers

The app is structured into the following layers:

Presenter Layer (Bloc): Contains the UI components, Blocs, and widgets responsible for rendering the user interface. Blocs manage the app's state and business logic.

Domain Layer: Contains business logic, entities, and use cases. The use cases encapsulate application-specific business rules and interact with the repository to fetch data.

Infra Layer: Handles data retrieval from different sources (e.g., API, database, local storage). It includes data models, repositories, and data sources. The repository acts as a single source of truth and decides whether to fetch data from the remote server or local cache.

## Core Folder

The app includes a core folder that holds files that are used throughout the entire app:

Constants: Contains constants such as API URLs, API keys, and other configuration values used across the app.
Widgets: Includes custom widgets and UI components that can be reused in different parts of the app.
Dependencies Abstractions: Defines abstractions for external packeges

## Exception Handling

The app utilizes a generic Failure class from the Dartz library to handle exceptions. The Failure class is an algebraic data type that represents possible failures or errors that may occur during data retrieval or other operations. It allows us to handle errors in a more structured way, making the code more robust and maintainable.