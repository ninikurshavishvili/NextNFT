//
//  TabbedItems.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 21.08.25.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable {
    case home = 0
    case search = 1
    case drops
    case profile
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .drops: return "Drops"
        case .profile: return "Profile"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .search: return "magnifyingglass"
        case .drops: return "calendar"
        case .profile: return "person"
        }
    }
}

import SwiftUI

@available(iOS 26.0, *)
struct CustomTabBarView: View {
    @Binding var selectedTab: TabbedItems
    
    var body: some View {
        HStack {
            ForEach(TabbedItems.allCases, id: \.self) { item in
                Spacer()
                Button {
                    selectedTab = item
                } label: {
                    VStack(spacing: 2) {
                        Image(systemName: item.icon)
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(selectedTab == item ? .mainPurple : .white.opacity(0.8))
                        
                        Text(item.title)
                            .font(.caption2)
                            .foregroundColor(selectedTab == item ? .mainPurple : .white.opacity(0.8))
                    }
                    .padding(.top, 20)
                }
                Spacer()
            }
        }
        .padding(.bottom, 20)
        .frame(height: 62)
        .background(
            
            // Use RoundedRectangle so the shape is clipped and we can apply material.
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.clear)
                
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 30))
        )
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
        .ignoresSafeArea(edges: .bottom)
    }
}


@available(iOS 26.0, *)
struct MainTabView: View {
    @State private var selectedTab: TabbedItems = .home
    // Owned here, so a tab keeps its data when you switch away and back
    @State private var homeViewModel: HomeViewModel
    @State private var carouselViewModel: NFTCarouselViewModel
    @State private var searchViewModel: SearchViewModel
    
    init(container: AppContainer) {
        _homeViewModel = State(initialValue: container.makeHomeViewModel())
        _carouselViewModel = State(initialValue: container.makeNFTCarouselViewModel())
        _searchViewModel = State(initialValue: container.makeSearchViewModel())
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // TabView keeps visited tabs alive; a `switch` rebuilt the screen,
            // and refetched its data, on every tab change. The system tab bar
            // is hidden in favour of CustomTabBarView.
            TabView(selection: $selectedTab) {
                Tab(TabbedItems.home.title, systemImage: TabbedItems.home.icon, value: .home) {
                    tabRoot {
                        HomeView(viewModel: homeViewModel, carouselViewModel: carouselViewModel)
                    }
                }
                Tab(TabbedItems.search.title, systemImage: TabbedItems.search.icon, value: .search) {
                    tabRoot {
                        SearchPageView(viewModel: searchViewModel)
                    }
                }
                Tab(TabbedItems.drops.title, systemImage: TabbedItems.drops.icon, value: .drops) {
                    tabRoot {
                        Text("Drops Page")
                            .foregroundColor(.white)
                    }
                }
                Tab(TabbedItems.profile.title, systemImage: TabbedItems.profile.icon, value: .profile) {
                    tabRoot {
                        Text("Profile Page")
                            .foregroundColor(.white)
                    }
                }
            }
            
            CustomTabBarView(selectedTab: $selectedTab)
                .frame(width: 360, height: 65)
                .padding(.bottom, 10)
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    /// Each tab gets its own navigation stack, ready for detail screens.
    private func tabRoot(@ViewBuilder content: () -> some View) -> some View {
        NavigationStack {
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppColors.darkBackground)
        }
        .toolbarVisibility(.hidden, for: .tabBar)
    }
}


#Preview {
    if #available(iOS 26.0, *) {
        MainTabView(container: AppContainer())
    } else {
        // Fallback on earlier versions
    }
}
