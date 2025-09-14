import SwiftUI

struct FilterSheetView: View {
    @ObservedObject var viewModel: SearchViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Mood Section
                    FilterSection(title: "How are you feeling?", icon: "face.smiling") {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                            ForEach(Mood.allCases, id: \.self) { mood in
                                FilterOptionCard(
                                    title: mood.rawValue,
                                    icon: mood.icon,
                                    isSelected: viewModel.selectedMood == mood
                                ) {
                                    viewModel.selectedMood = viewModel.selectedMood == mood ? nil : mood
                                }
                            }
                        }
                    }
                    
                    // Distance Section
                    FilterSection(title: "How far are you willing to go?", icon: "location") {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                            ForEach(Distance.allCases, id: \.self) { distance in
                                FilterOptionCard(
                                    title: distance.displayName,
                                    icon: "location.fill",
                                    isSelected: viewModel.selectedDistance == distance
                                ) {
                                    viewModel.selectedDistance = viewModel.selectedDistance == distance ? nil : distance
                                }
                            }
                        }
                    }
                    
                    // Price Range Section
                    FilterSection(title: "What's your budget?", icon: "dollarsign.circle") {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                            ForEach(PriceRange.allCases, id: \.self) { priceRange in
                                FilterOptionCard(
                                    title: priceRange.displayName,
                                    icon: priceRange.icon,
                                    isSelected: viewModel.selectedPriceRange == priceRange
                                ) {
                                    viewModel.selectedPriceRange = viewModel.selectedPriceRange == priceRange ? nil : priceRange
                                }
                            }
                        }
                    }
                    
                    // Cuisine Section
                    FilterSection(title: "What type of cuisine?", icon: "fork.knife") {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                            ForEach(Cuisine.allCases, id: \.self) { cuisine in
                                FilterOptionCard(
                                    title: cuisine.rawValue,
                                    icon: cuisine.icon,
                                    isSelected: viewModel.selectedCuisine == cuisine
                                ) {
                                    viewModel.selectedCuisine = viewModel.selectedCuisine == cuisine ? nil : cuisine
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear All") {
                        viewModel.clearAllFilters()
                    }
                    .foregroundColor(.red)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

struct FilterSection<Content: View>: View {
    let title: String
    let icon: String
    let content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .font(.title3)
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            content
        }
    }
}

struct FilterOptionCard: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(isSelected ? .white : .blue)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .white : .primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FilterSheetView(viewModel: SearchViewModel())
}
