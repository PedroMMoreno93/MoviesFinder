## 🎉 Release v1.0.0

**MoviesFinder 1.0.0** marks the first public release of the app. This version includes:

- **Movie Browser**  
  • Fetches lists of movies from TMDB  
  • Group by genre & sort by popularity, release date, rating  
  • Detail view navigation
    
- **Movie Detail**  
  • Includes movie info such as language, country and release dates
  • Shows cast and crew members

- **Status Bar Integration**  
  • Show/hide the main window  
  • Quick list access & detail navigation  
  • Quit the app from the menu  

- **Welcome & Settings Screens**  
  • First-launch welcome window  
  • Settings pane for theme selection (light/dark/system)  
  • “Launch at Login” toggle powered by [LaunchAtLogin](https://github.com/sindresorhus/LaunchAtLogin-Legacy)  

- **Architecture & Modularity**  
  • Clean Architecture (Domain/Data/Presentation)  
  • MVVM in Presentation layer  
  • Swift package modules: Theme, UIComponents, Utils, NetworkSystem, MVVM Core  

- **Testing**  
  • Unit tests for domain use cases, data mapping, and ViewModels  

- **Universal & Signed Installer**  
  • Builds universal (x86_64 + arm64) binary  
  • Generates a signed `.pkg` via `scripts/main.sh`  

---
