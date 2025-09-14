import Foundation

// MARK: - Restaurant Model
struct Restaurant: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let cuisine: Cuisine
    let priceRange: PriceRange
    let rating: Double
    let reviewCount: Int
    let distance: Double // in miles
    let imageURL: String
    let address: String
    let phone: String
    let description: String
    let isOpen: Bool
    let deliveryTime: String
    let tags: [String]
    
    var formattedRating: String {
        return String(format: "%.1f", rating)
    }
    
    var formattedDistance: String {
        return String(format: "%.1f mi", distance)
    }
}

// MARK: - Search Criteria Models
enum Mood: String, CaseIterable {
    case happy = "Happy"
    case romantic = "Romantic"
    case adventurous = "Adventurous"
    case comfort = "Comfort"
    case healthy = "Healthy"
    case indulgent = "Indulgent"
    case social = "Social"
    case cozy = "Cozy"
    
    var icon: String {
        switch self {
        case .happy: return "face.smiling"
        case .romantic: return "heart.fill"
        case .adventurous: return "mountain.2.fill"
        case .comfort: return "house.fill"
        case .healthy: return "leaf.fill"
        case .indulgent: return "star.fill"
        case .social: return "person.3.fill"
        case .cozy: return "flame.fill"
        }
    }
}

enum Distance: CaseIterable {
    case walking
    case shortDrive
    case mediumDrive
    case longDrive
    
    var displayName: String {
        switch self {
        case .walking: return "Walking (0-0.5 mi)"
        case .shortDrive: return "Short Drive (0.5-2 mi)"
        case .mediumDrive: return "Medium Drive (2-5 mi)"
        case .longDrive: return "Long Drive (5+ mi)"
        }
    }
    
    var maxDistance: Double {
        switch self {
        case .walking: return 0.5
        case .shortDrive: return 2.0
        case .mediumDrive: return 5.0
        case .longDrive: return Double.infinity
        }
    }
}

enum PriceRange: CaseIterable {
    case budget
    case moderate
    case expensive
    case luxury
    
    var displayName: String {
        switch self {
        case .budget: return "$"
        case .moderate: return "$$"
        case .expensive: return "$$$"
        case .luxury: return "$$$$"
        }
    }
    
    var icon: String {
        switch self {
        case .budget: return "dollarsign.circle"
        case .moderate: return "dollarsign.circle.fill"
        case .expensive: return "dollarsign.square"
        case .luxury: return "dollarsign.square.fill"
        }
    }
}

enum Cuisine: String, CaseIterable {
    case italian = "Italian"
    case chinese = "Chinese"
    case mexican = "Mexican"
    case japanese = "Japanese"
    case indian = "Indian"
    case thai = "Thai"
    case american = "American"
    case mediterranean = "Mediterranean"
    case french = "French"
    case korean = "Korean"
    case vietnamese = "Vietnamese"
    case greek = "Greek"
    case spanish = "Spanish"
    case brazilian = "Brazilian"
    case ethiopian = "Ethiopian"
    case lebanese = "Lebanese"
    case turkish = "Turkish"
    case fusion = "Fusion"
    case seafood = "Seafood"
    case vegetarian = "Vegetarian"
    case vegan = "Vegan"
    case fastFood = "Fast Food"
    case cafe = "Café"
    case bakery = "Bakery"
    case dessert = "Dessert"
    case bar = "Bar & Grill"
    
    var icon: String {
        switch self {
        case .italian: return "🍝"
        case .chinese: return "🥢"
        case .mexican: return "🌮"
        case .japanese: return "🍣"
        case .indian: return "🍛"
        case .thai: return "🌶️"
        case .american: return "🍔"
        case .mediterranean: return "🫒"
        case .french: return "🥐"
        case .korean: return "🥘"
        case .vietnamese: return "🍜"
        case .greek: return "🥙"
        case .spanish: return "🥘"
        case .brazilian: return "🍖"
        case .ethiopian: return "🍲"
        case .lebanese: return "🥗"
        case .turkish: return "🥙"
        case .fusion: return "🍽️"
        case .seafood: return "🦐"
        case .vegetarian: return "🥬"
        case .vegan: return "🌱"
        case .fastFood: return "🍟"
        case .cafe: return "☕"
        case .bakery: return "🥖"
        case .dessert: return "🍰"
        case .bar: return "🍺"
        }
    }
}
