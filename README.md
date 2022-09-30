<p align="center">
<a href="#">
<img src="./external/logo.png" alt="Logo" width=72 height=72/>
</a>
<h3 align="center">Weather Forecast</h3>
<p align="center">
    ☁️This is the open source of the weather forecast app☁️
</p>
</p>

## Table of contents

- [Quick start](#quick-start)
- [What's included](#whats-included)

## Quick start
The features:
- On opening the app for the first time, the application requires access to your location, by default it will take a location in the capital city of Hanoi, Vietnam.
![access-location](/external/access-location.png "access location")

- On next visit, the app automatically uses your current location (or last location) to display forecast results
![open-app](/external/open_app.gif "open app")

- See the forecast at one location on the map
![select-map](/external/select_location_map.gif "select map")

- Search location
![search](/external/search.gif "search")

- Others features: change layers map, change theme

## What's included
The application is implemented by flutter framework with BLoC pattern

```text
root/
└── assets/
    ├── constants/
    │   ├── international files
    └── images/
        └── image files
└── lib/
    ├── bloc/
    ├── dependencies/
    ├── global/
    ├── I10n/
    ├── models/
    ├── pages/
    ├── services/
    └── other files
```