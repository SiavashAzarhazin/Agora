import SwiftUI

struct ContentView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HeaderView()
                
                // Search Interface
                SearchInterfaceView(viewModel: searchViewModel)
                
                // Results
                RestaurantListView(restaurants: searchViewModel.filteredRestaurants)
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Agora")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient.agoraGradient)
                        .fadeInWithScale(delay: 0.1)
                    
                    Text("Find your perfect meal")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fadeInWithScale(delay: 0.2)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "person.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                        .bounce(delay: 0.3)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    ContentView()
}
