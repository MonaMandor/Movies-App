# TMDB Client

This is a basic TMDB client application built using Flutter. The app demonstrates key functionalities such as authentication, viewing different categories of movies (now playing, popular, top-rated, upcoming), viewing movie details, adding movies to a watchlist, and viewing the watchlist. The project follows Clean Architecture principles and uses the BLoC pattern for state management.

## Usage
Upon launching the app, users can either log in using their TMDB credentials or skip login to browse anonymously. Authenticated users have additional functionalities such as adding movies to their watchlist and viewing their watchlist. Users can view now playing, popular, top-rated, and upcoming movies. They can also see detailed information about each movie.

- ## Apk,i also upload it in files: [Apk](https://drive.google.com/file/d/1hUIdHKSHIj70Ii_2aOpHj-m10z0cCVb1/view?usp=drive_link)
- Dimo: [Dimo](https://drive.google.com/file/d/1hUIdHKSHIj70Ii_2aOpHj-m10z0cCVb1/view?usp=drive_link)


## Features

- User authentication with TMDB API (login and logout)
- Viewing a list of now playing movies with pagination
- Viewing a list of popular movies with pagination
- Viewing a list of top-rated movies with pagination
- Viewing a list of upcoming movies with pagination
- Viewing detailed information for each movie
- Adding movies to a watchlist
- Viewing and removing movies from the watchlist
- Persistent session management using Shared Preferences
- Support for responsive design (height, width, font sizes)
- Reusable components for consistent UI

## Architecture

This project follows the Clean Architecture principles to ensure separation of concerns, scalability, and testability. The codebase is divided into three main layers:

1. **Presentation Layer**: Contains UI components and BLoC classes.
2. **Domain Layer**: Contains business logic, use cases, and repository interfaces.
3. **Data Layer**: Contains repository implementations, data sources, and models.

## Why Clean Architecture?
Clean Architecture provides a way to organize code in a way that separates concerns across different layers, ensuring:

1. **Maintainability**: Easier to modify and extend the application.
2. **Testability**: Each layer can be tested independently.
3.  **Scalability**: Facilitates adding new features without major rewrites.
By adhering to Clean Architecture, the codebase becomes more robust and adaptable to changes, reducing the risk of bugs and making the development process more efficient.

https://github.com/MonaMandor/Movies-App/assets/105756168/d393aacd-3199-448d-be88-fee5e60de266


