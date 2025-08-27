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
                            .foregroundColor(selectedTab == item ? .mainPurple : .white)
                        
                        Text(item.title)
                            .font(.caption)
                            .foregroundColor(selectedTab == item ? .mainPurple : .white)
                    }
                    .padding(.vertical, 10)
                }
                
                Spacer()
            }
        }
        .padding(.bottom)
        .frame(height: 80)
        .background(AppColors.darkGrey)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct MainTabView: View {
    @State private var selectedTab: TabbedItems = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
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
        .ignoresSafeArea(edges: .bottom)
    }
}


#Preview {
    MainTabView()
}

