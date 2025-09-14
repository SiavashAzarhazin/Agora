import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedMood: Mood?
    @Published var selectedDistance: Distance?
    @Published var selectedPriceRange: PriceRange?
    @Published var selectedCuisine: Cuisine?
    
    @Published var restaurants: [Restaurant] = []
    @Published var filteredRestaurants: [Restaurant] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupRestaurants()
        setupFiltering()
    }
    
    var hasActiveFilters: Bool {
        selectedMood != nil || selectedDistance != nil || selectedPriceRange != nil || selectedCuisine != nil
    }
    
    func clearAllFilters() {
        selectedMood = nil
        selectedDistance = nil
        selectedPriceRange = nil
        selectedCuisine = nil
    }
    
    private func setupFiltering() {
        Publishers.CombineLatest(
            Publishers.CombineLatest3($searchText, $selectedMood, $selectedDistance),
            Publishers.CombineLatest($selectedPriceRange, $selectedCuisine)
        )
        .map { [weak self] searchMoodDistance, priceCuisine in
            guard let self = self else { return [] }
            
            let (searchText, mood, distance) = searchMoodDistance
            let (priceRange, cuisine) = priceCuisine
            
            return self.restaurants.filter { restaurant in
                // Text search
                let matchesText = searchText.isEmpty || 
                    restaurant.name.localizedCaseInsensitiveContains(searchText) ||
                    restaurant.description.localizedCaseInsensitiveContains(searchText) ||
                    restaurant.tags.contains { $0.localizedCaseInsensitiveContains(searchText) }
                
                // Mood filter (this would be more complex in a real app)
                let matchesMood = mood == nil || self.restaurantMatchesMood(restaurant, mood: mood!)
                
                // Distance filter
                let matchesDistance = distance == nil || restaurant.distance <= distance!.maxDistance
                
                // Price range filter
                let matchesPrice = priceRange == nil || restaurant.priceRange == priceRange
                
                // Cuisine filter
                let matchesCuisine = cuisine == nil || restaurant.cuisine == cuisine
                
                return matchesText && matchesMood && matchesDistance && matchesPrice && matchesCuisine
            }
        }
        .assign(to: &$filteredRestaurants)
    }
    
    private func restaurantMatchesMood(_ restaurant: Restaurant, mood: Mood) -> Bool {
        // This is a simplified mood matching logic
        // In a real app, this would be more sophisticated
        switch mood {
        case .happy:
            return restaurant.rating >= 4.0 || restaurant.tags.contains("fun")
        case .romantic:
            return restaurant.tags.contains("romantic") || restaurant.cuisine == .french || restaurant.cuisine == .italian
        case .adventurous:
            return restaurant.cuisine == .ethiopian || restaurant.cuisine == .korean || restaurant.cuisine == .vietnamese
        case .comfort:
            return restaurant.cuisine == .american || restaurant.tags.contains("comfort")
        case .healthy:
            return restaurant.cuisine == .vegetarian || restaurant.cuisine == .vegan || restaurant.tags.contains("healthy")
        case .indulgent:
            return restaurant.priceRange == .expensive || restaurant.priceRange == .luxury
        case .social:
            return restaurant.tags.contains("social") || restaurant.cuisine == .bar
        case .cozy:
            return restaurant.tags.contains("cozy") || restaurant.cuisine == .cafe
        }
    }
    
    private func setupRestaurants() {
        restaurants = [
            Restaurant(
                name: "Bella Vista",
                cuisine: .italian,
                priceRange: .moderate,
                rating: 4.5,
                reviewCount: 234,
                distance: 0.8,
                imageURL: "https://example.com/bella-vista.jpg",
                address: "123 Main St, Downtown",
                phone: "(555) 123-4567",
                description: "Authentic Italian cuisine with a modern twist. Fresh pasta made daily.",
                isOpen: true,
                deliveryTime: "25-35 min",
                tags: ["romantic", "authentic", "pasta"]
            ),
            Restaurant(
                name: "Sakura Sushi",
                cuisine: .japanese,
                priceRange: .expensive,
                rating: 4.8,
                reviewCount: 189,
                distance: 1.2,
                imageURL: "https://example.com/sakura.jpg",
                address: "456 Oak Ave, Midtown",
                phone: "(555) 234-5678",
                description: "Premium sushi and sashimi with traditional Japanese techniques.",
                isOpen: true,
                deliveryTime: "30-40 min",
                tags: ["fresh", "premium", "traditional"]
            ),
            Restaurant(
                name: "Spice Garden",
                cuisine: .indian,
                priceRange: .moderate,
                rating: 4.3,
                reviewCount: 156,
                distance: 0.5,
                imageURL: "https://example.com/spice-garden.jpg",
                address: "789 Pine St, Old Town",
                phone: "(555) 345-6789",
                description: "Traditional Indian curries and tandoor specialties.",
                isOpen: true,
                deliveryTime: "20-30 min",
                tags: ["spicy", "traditional", "vegetarian-friendly"]
            ),
            Restaurant(
                name: "Green Leaf Café",
                cuisine: .vegetarian,
                priceRange: .budget,
                rating: 4.2,
                reviewCount: 98,
                distance: 0.3,
                imageURL: "https://example.com/green-leaf.jpg",
                address: "321 Elm St, University District",
                phone: "(555) 456-7890",
                description: "Fresh, organic vegetarian and vegan dishes with locally sourced ingredients.",
                isOpen: true,
                deliveryTime: "15-25 min",
                tags: ["healthy", "organic", "vegan-friendly"]
            ),
            Restaurant(
                name: "Taco Libre",
                cuisine: .mexican,
                priceRange: .budget,
                rating: 4.1,
                reviewCount: 203,
                distance: 1.5,
                imageURL: "https://example.com/taco-libre.jpg",
                address: "654 Maple Dr, Westside",
                phone: "(555) 567-8901",
                description: "Authentic Mexican street food with fresh ingredients and bold flavors.",
                isOpen: true,
                deliveryTime: "18-28 min",
                tags: ["authentic", "spicy", "street-food"]
            ),
            Restaurant(
                name: "Le Petit Bistro",
                cuisine: .french,
                priceRange: .expensive,
                rating: 4.7,
                reviewCount: 145,
                distance: 2.1,
                imageURL: "https://example.com/le-petit.jpg",
                address: "987 Cedar Ln, Historic District",
                phone: "(555) 678-9012",
                description: "Classic French bistro with an extensive wine selection and elegant atmosphere.",
                isOpen: true,
                deliveryTime: "35-45 min",
                tags: ["romantic", "elegant", "wine"]
            ),
            Restaurant(
                name: "Golden Dragon",
                cuisine: .chinese,
                priceRange: .moderate,
                rating: 4.0,
                reviewCount: 167,
                distance: 0.9,
                imageURL: "https://example.com/golden-dragon.jpg",
                address: "147 Birch St, Chinatown",
                phone: "(555) 789-0123",
                description: "Traditional Chinese cuisine with dim sum and authentic regional dishes.",
                isOpen: true,
                deliveryTime: "22-32 min",
                tags: ["traditional", "dim-sum", "family-friendly"]
            ),
            Restaurant(
                name: "Burger Junction",
                cuisine: .american,
                priceRange: .budget,
                rating: 3.9,
                reviewCount: 89,
                distance: 0.7,
                imageURL: "https://example.com/burger-junction.jpg",
                address: "258 Spruce Ave, Downtown",
                phone: "(555) 890-1234",
                description: "Gourmet burgers with fresh ingredients and creative combinations.",
                isOpen: true,
                deliveryTime: "15-25 min",
                tags: ["comfort", "gourmet", "quick"]
            )
        ]
    }
}
