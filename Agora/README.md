# Agora - Restaurant Discovery App

Agora is a modern SwiftUI app designed to help users discover restaurants based on their cravings, mood, distance preferences, and other criteria.

## Features

### 🔍 Smart Search
- **Text Search**: Search by restaurant name, description, or tags
- **Mood-Based Filtering**: Find restaurants that match your current mood (Happy, Romantic, Adventurous, Comfort, Healthy, Indulgent, Social, Cozy)
- **Distance Filtering**: Filter by walking distance, short drive, medium drive, or long drive
- **Price Range**: Filter by budget ($), moderate ($$), expensive ($$$), or luxury ($$$$)
- **Cuisine Types**: 25+ cuisine types including Italian, Japanese, Indian, Mexican, and more

### 🎨 Modern UI/UX
- **Beautiful Design**: Clean, modern interface with custom gradients and animations
- **Smooth Animations**: Fade-in, slide-in, bounce, and pulse animations for enhanced user experience
- **Card-Based Layout**: Restaurant cards with high-quality images and essential information
- **Interactive Filters**: Easy-to-use filter pills and comprehensive filter sheet

### 📱 Key Views
- **Search Interface**: Main search bar with quick filter access
- **Filter Sheet**: Comprehensive filtering options with visual icons
- **Restaurant List**: Grid of restaurant cards with ratings, distance, and status
- **Restaurant Detail**: Full restaurant information with contact details and actions

### 🏪 Restaurant Information
- **Comprehensive Details**: Name, cuisine, price range, rating, reviews, distance
- **Visual Status**: Open/closed status with color-coded indicators
- **Delivery Information**: Estimated delivery times
- **Contact Actions**: Call restaurant and get directions buttons
- **Tags & Highlights**: Key features and characteristics

## Technical Implementation

### Architecture
- **MVVM Pattern**: Clean separation of concerns with ViewModels
- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming for search and filtering
- **ObservableObject**: State management for search criteria

### Data Models
- **Restaurant**: Complete restaurant information model
- **Search Criteria**: Enums for mood, distance, price range, and cuisine
- **Filtering Logic**: Smart matching algorithms for mood-based recommendations

### Custom Components
- **FilterPill**: Interactive filter selection chips
- **RestaurantCard**: Rich restaurant information cards
- **FilterSheet**: Comprehensive filtering interface
- **Custom Animations**: Smooth transitions and micro-interactions

## Getting Started

1. **Open in Xcode**: Open the project in Xcode 15.0 or later
2. **Build & Run**: Select your target device and run the app
3. **Explore**: Use the search bar and filters to discover restaurants

## Sample Data

The app includes sample restaurant data with:
- 8 diverse restaurants across different cuisines
- Realistic ratings, distances, and descriptions
- Various price ranges and delivery times
- Rich tags and characteristics for mood matching

## Customization

### Adding New Restaurants
Edit the `setupRestaurants()` method in `SearchViewModel.swift` to add new restaurant data.

### Modifying Filters
Update the enum cases in `Models.swift` to add new mood types, cuisines, or distance ranges.

### Styling
Customize colors, gradients, and animations in `Extensions.swift` and `Animations.swift`.

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Future Enhancements

- **Real Restaurant Data**: Integration with restaurant APIs
- **Location Services**: GPS-based distance calculations
- **User Reviews**: Rating and review system
- **Favorites**: Save favorite restaurants
- **Recommendations**: AI-powered restaurant suggestions
- **Social Features**: Share restaurants with friends
- **Reservations**: Book tables directly through the app

---

Built with ❤️ using SwiftUI
