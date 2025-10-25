//
//  TabbedItems.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 21.08.25.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable {
    case home = 0
    case search
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
                    VStack(spacing: 6) {
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
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView(viewModel: CollectionsViewModel())
                case .search:
                    Text("Search Page")
                        .foregroundColor(.white)
                case .drops:
                    Text("Drops Page")
                        .foregroundColor(.white)
                case .profile:
                    Text("Profile Page")
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColors.darkBackground)
            .ignoresSafeArea()
            
            CustomTabBarView(selectedTab: $selectedTab)
                .frame(maxWidth: .infinity)
        }
    }
}


#Preview {
    if #available(iOS 26.0, *) {
        MainTabView()
    } else {
        // Fallback on earlier versions
    }
}

