import SwiftUI

struct RestaurantListView: View {
    let restaurants: [Restaurant]
    
    var body: some View {
        if restaurants.isEmpty {
            EmptyStateView()
        } else {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(restaurants) { restaurant in
                        NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                            RestaurantCardView(restaurant: restaurant)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
        }
    }
}

struct RestaurantCardView: View {
    let restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Restaurant Image
            AsyncImage(url: URL(string: restaurant.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color(.systemGray5))
                    .overlay(
                        Image(systemName: "photo")
                            .font(.title)
                            .foregroundColor(.secondary)
                    )
            }
            .frame(height: 200)
            .clipped()
            .cornerRadius(12)
            .overlay(
                // Status indicator
                VStack {
                    HStack {
                        Spacer()
                        HStack(spacing: 4) {
                            Circle()
                                .fill(restaurant.isOpen ? Color.green : Color.red)
                                .frame(width: 8, height: 8)
                            
                            Text(restaurant.isOpen ? "Open" : "Closed")
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(8)
                        .padding(12)
                    }
                    Spacer()
                }
            )
            
            // Restaurant Info
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(restaurant.name)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        HStack(spacing: 4) {
                            Text(restaurant.cuisine.rawValue)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("•")
                                .foregroundColor(.secondary)
                            
                            Text(restaurant.priceRange.displayName)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("•")
                                .foregroundColor(.secondary)
                            
                            Text(restaurant.formattedDistance)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.caption)
                            
                            Text(restaurant.formattedRating)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        
                        Text("(\(restaurant.reviewCount))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Text(restaurant.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                // Tags
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(restaurant.tags.prefix(3), id: \.self) { tag in
                            Text(tag.capitalized)
                                .font(.caption2)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 1)
                }
                
                // Delivery Info
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.blue)
                            .font(.caption)
                        
                        Text("Delivery: \(restaurant.deliveryTime)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                            .font(.caption)
                        
                        Text(restaurant.formattedDistance)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal, 4)
        }
        .padding(16)
        .cardStyle()
        .slideInFromBottom(delay: Double.random(in: 0.1...0.3))
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            VStack(spacing: 8) {
                Text("No restaurants found")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text("Try adjusting your search or filters to find more options")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    RestaurantListView(restaurants: [])
}
