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
<img src="./external/access-location.png" alt="access location" style="width: 25%; height: 25%;"/>

- On next visit, the app automatically uses your current location (or last location) to display forecast results
<img src="./external/open_app.gif" alt="open app" style="width: 25%; height: 25%;"/>

- See the forecast at one location on the map
<img src="./external/select_location_map.gif" alt="select map" style="width: 25%; height: 25%;"/>

- Search location
<img src="./external/search.gif" alt="search" style="width: 25%; height: 25%;"/>

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
