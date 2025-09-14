import SwiftUI

struct SearchInterfaceView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State private var showingFilters = false
    
    var body: some View {
        VStack(spacing: 16) {
            // Main Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("What are you craving?", text: $viewModel.searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                
                if !viewModel.searchText.isEmpty {
                    Button(action: {
                        viewModel.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal, 20)
            
            // Quick Filter Pills
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    FilterPill(
                        title: "Mood",
                        icon: "face.smiling",
                        isSelected: viewModel.selectedMood != nil
                    ) {
                        showingFilters = true
                    }
                    
                    FilterPill(
                        title: "Distance",
                        icon: "location",
                        isSelected: viewModel.selectedDistance != nil
                    ) {
                        showingFilters = true
                    }
                    
                    FilterPill(
                        title: "Price",
                        icon: "dollarsign.circle",
                        isSelected: viewModel.selectedPriceRange != nil
                    ) {
                        showingFilters = true
                    }
                    
                    FilterPill(
                        title: "Cuisine",
                        icon: "fork.knife",
                        isSelected: viewModel.selectedCuisine != nil
                    ) {
                        showingFilters = true
                    }
                }
                .padding(.horizontal, 20)
            }
            
            // Active Filters
            if viewModel.hasActiveFilters {
                ActiveFiltersView(viewModel: viewModel)
            }
        }
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .sheet(isPresented: $showingFilters) {
            FilterSheetView(viewModel: viewModel)
        }
    }
}

struct FilterPill: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(20)
        }
    }
}

struct ActiveFiltersView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                if let mood = viewModel.selectedMood {
                    ActiveFilterChip(title: mood.rawValue) {
                        viewModel.selectedMood = nil
                    }
                }
                
                if let distance = viewModel.selectedDistance {
                    ActiveFilterChip(title: distance.displayName) {
                        viewModel.selectedDistance = nil
                    }
                }
                
                if let priceRange = viewModel.selectedPriceRange {
                    ActiveFilterChip(title: priceRange.displayName) {
                        viewModel.selectedPriceRange = nil
                    }
                }
                
                if let cuisine = viewModel.selectedCuisine {
                    ActiveFilterChip(title: cuisine.rawValue) {
                        viewModel.selectedCuisine = nil
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct ActiveFilterChip: View {
    let title: String
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
            
            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .font(.caption2)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.blue.opacity(0.1))
        .foregroundColor(.blue)
        .cornerRadius(12)
    }
}

#Preview {
    SearchInterfaceView(viewModel: SearchViewModel())
}
