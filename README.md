# FFFinder

## Links

- GitHub: [https://github.com/zzwzzwzz/FFFinder](https://github.com/zzwzzwzz/FFFinder)
- YouTube: [https://youtube.com/shorts/CIIt9HcDG1k] (https://youtube.com/shorts/CIIt9HcDG1k)

## Intro

**FFFinder** is a modern SwiftUI app that helps users discover film festivals and award-winning films, with a focus on Sydney and international cinema. The app features a beautiful, consistent design, advanced search and filtering, and seamless navigation.

> **Note:** This project was developed as an MVP (Minimum Viable Product) to demonstrate core features and design for film festival discovery.

## Features

- **Home:**  
  - See upcoming featured festivals and popular films at a glance.
  - Quick access to search and navigation.

- **All Festivals & All Films:**  
  - Browse all festivals and films with advanced filtering and sorting (by popularity, name, or date).
  - Switch between festivals and films with a tab interface.

- **Festival Detail View:**
  - View rich details about each festival, including logo, description, dates, location, genres, ticket prices, and venue address.
  - See a list of recent award-winning films for each festival.
  - Mark festivals as favorites.

- **Film Detail View:**
  - Explore detailed information about each film, including poster, synopsis, director, year, and awards.
  - View links to IMDb, Letterboxd, and Rotten Tomatoes.
  - See which festivals the film has won awards at, and navigate to those festivals.
  - Mark films as favorites.

- **Search:**  
  - Powerful search for both festivals and films.
  - Filter by genre (for festivals).
  - Instantly view results with logos and posters.
  - Dismiss search with a convenient close icon.

- **Favorites:**  
  - Save your favorite festivals and films for quick access.

- **Profile:**  
  - View your profile with a modern card design.
  - Access settings, notifications, help & support, and about pages.
  - Log out securely.

- **Notifications:**  
  - Stay up to date with festival news and app updates.
  - Mark notifications as read.

- **Settings:**  
  - Manage your account and app preferences.
  - Log out with one tap.

- **Help & Support:**  
  - Browse FAQs and contact support.

- **About:**  
  - Learn more about the app and the team.

## Architecture

- **SwiftUI** for all UI and navigation.
- **MVVM** (Model-View-ViewModel) architecture for clean separation of logic and UI.
- **Models:**  
  - `FilmFestival`: Represents a festival, with name, date, description, logo, genres, and featured films.
  - `Film`: Represents a film, with title, year, director, description, poster, and awards.
- **ViewModels:**  
  - `FestivalsViewModel`: Manages festival and film data, search, and favorites.
  - `NotificationViewModel`: Manages notifications.
- **Services:**  
  - `TMDBService`: Integrates with The Movie Database (TMDB) API to fetch film posters and details.

## Setup & Requirements

- **Xcode 15+**
- **iOS 16+**
- Clone the repository and open `FFFinder.xcodeproj` in Xcode.
- Build and run on a simulator or device.

## Customization

- Add or update festival and film data in `FFFinder/Models/FilmFestival.swift` and `Film.swift`.
- Update app colors in `FFFinder/Models/Colors.swift`.

## Credits

- Developed by Team Cinephiles.
- Film data and posters powered by [TMDB](https://www.themoviedb.org/).

## License

© 2025 FFFinder. All rights reserved.
