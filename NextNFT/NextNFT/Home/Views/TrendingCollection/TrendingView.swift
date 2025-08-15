//
//  Untitled.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 13.08.25.
//

import SwiftUI

struct TrendingView: View {
    @State private var selectedTab = "Collections"
    @State private var selectedIconIndex = 3
    @State private var selectedDay = "1D"
    
    let tabs = ["Collections", "Marketplaces"]
    let icons = ["square.stack.3d.up", "ethereum.sign", "dollarsign.circle", "leaf.fill", "flame.fill", "bitcoinsign.circle", "dollarsign.circle", "bitcoinsign.circle.fill"]
    let days = ["1H", "4H", "1D", "7D", "30D"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Trending")
                .font(.system(.title, design: .serif, weight: .bold))
                .foregroundStyle(.white)
            
            HStack(alignment: .firstTextBaseline) {
                ForEach(tabs, id: \.self) { tab in
                    VStack {
                        Text(tab)
                            .foregroundStyle(selectedTab == tab ? .white : .gray)
                            .fontWeight(.medium)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(selectedTab == tab ? .white : .clear)
                    }
                    .onTapGesture {
                        selectedTab = tab
                    }
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(icons.indices, id: \.self) { index in
                        Button {
                            selectedIconIndex = index
                        } label: {
                            Image(systemName: icons[index])
                                .font(.system(size: 20))
                                .foregroundStyle(index == selectedIconIndex ? .white : AppColors.lightGrey)
                                .frame(width: 40, height: 40)
                                .background(
                                    index == selectedIconIndex ?
                                        Color.black.opacity(0.7) : Color.clear
                                )
                                .cornerRadius(12)
                        }
                    }
                }
                .padding(4)
                .background(AppColors.lightGrey.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }


            
            // Days Scroll
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(days, id: \.self) { day in
                        Button {
                            selectedDay = day
                        } label: {
                            Text(day)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(width: 58, height: 40)
                                .background(selectedDay == day ? Color.black.opacity(0.7) : Color.clear)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
                .padding(4)
                .background(AppColors.lightGrey.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            
            // Floor Price
            VStack(alignment: .leading, spacing: 10) {
                Text("Floor price")
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
                
                HStack {
                    TextField("", text: .constant(""), prompt: Text("Min").foregroundStyle(.gray))
                        .multilineTextAlignment(.center)
                        .frame(width: 70, height: 44)
                        .background(Color.black.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text("—")
                        .foregroundStyle(.white)
                    
                    TextField("", text: .constant(""), prompt: Text("Max").foregroundStyle(.gray))
                        .multilineTextAlignment(.center)
                        .frame(width: 70, height: 44)
                        .background(Color.black.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text("ETH")
                        .foregroundStyle(.white)
                        .padding(.leading, 5)
                }

            }
        }
        .padding()
    }
}

#Preview {
    TrendingView()
        .background(AppColors.darkBackground)
}
