# DataCache

A SwiftUI application that displays and manages earthquake data using SwiftData for persistence. The app fetches real-time earthquake data from the USGS API and provides an interactive interface to view and filter earthquake information.

## Features

- Real-time earthquake data from USGS API
- Interactive map view showing earthquake locations
- List view with detailed earthquake information
- Filter earthquakes by date
- Sort earthquakes by magnitude or time
- Delete individual earthquakes or clear all data
- Persistent storage using SwiftData
- Beautiful and intuitive SwiftUI interface

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository:
```bash
git clone git@github.com:mdo91/DataCache.git
```

2. Open the project in Xcode:
```bash
cd DataCache
open DataCache.xcodeproj
```

3. Build and run the project (⌘R)

## Usage

The app provides several key features:

- **Map View**: Displays earthquake locations on an interactive map
- **List View**: Shows detailed information about each earthquake
- **Date Filter**: Filter earthquakes by specific dates
- **Sort Options**: Sort earthquakes by magnitude or time
- **Delete Options**: Remove individual earthquakes or clear all data
- **Refresh**: Update earthquake data from USGS

## Architecture

The app is built using:
- SwiftUI for the user interface
- SwiftData for data persistence
- MVVM architecture pattern
- USGS Earthquake API for data

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is available under the MIT license. See the LICENSE file for more info. 