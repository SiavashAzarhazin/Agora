import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Hero Image
                AsyncImage(url: URL(string: restaurant.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .overlay(
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundColor(.secondary)
                        )
                }
                .frame(height: 300)
                .clipped()
                .overlay(
                    // Gradient overlay
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.3)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay(
                    // Back button
                    VStack {
                        HStack {
                            Button(action: { dismiss() }) {
                                Image(systemName: "chevron.left")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .background(Color.black.opacity(0.3))
                                    .clipShape(Circle())
                            }
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "heart")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .background(Color.black.opacity(0.3))
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                )
                
                VStack(alignment: .leading, spacing: 20) {
                    // Restaurant Header
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(restaurant.name)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                
                                HStack(spacing: 8) {
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
                                        .font(.title3)
                                    
                                    Text(restaurant.formattedRating)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                                
                                Text("(\(restaurant.reviewCount) reviews)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        // Status
                        HStack(spacing: 8) {
                            Circle()
                                .fill(restaurant.isOpen ? Color.green : Color.red)
                                .frame(width: 12, height: 12)
                            
                            Text(restaurant.isOpen ? "Open now" : "Closed")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(restaurant.isOpen ? .green : .red)
                            
                            Spacer()
                            
                            Text("Delivery: \(restaurant.deliveryTime)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("About")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text(restaurant.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }
                    
                    // Tags
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Highlights")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                            ForEach(restaurant.tags, id: \.self) { tag in
                                Text(tag.capitalized)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    
                    // Contact Info
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Contact & Location")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 8) {
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.blue)
                                    .frame(width: 20)
                                
                                Text(restaurant.address)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Image(systemName: "phone.fill")
                                    .foregroundColor(.blue)
                                    .frame(width: 20)
                                
                                Text(restaurant.phone)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                        }
                    }
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "phone.fill")
                                Text("Call Restaurant")
                            }
                            .primaryButtonStyle()
                        }
                        .bounce(delay: 0.1)
                        
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "car.fill")
                                Text("Get Directions")
                            }
                            .secondaryButtonStyle()
                        }
                        .bounce(delay: 0.2)
                    }
                }
                .padding(20)
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    RestaurantDetailView(restaurant: Restaurant(
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
    ))
}
