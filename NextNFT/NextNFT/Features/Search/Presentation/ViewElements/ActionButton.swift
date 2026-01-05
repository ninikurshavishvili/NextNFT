//
//  ActionButton.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//
import SwiftUI

struct ActionButton: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(title)
        }
        .font(.caption)
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.15))
        .cornerRadius(14)
    }
}

func sectionHeader(_ title: String) -> some View {
    HStack {
        Text(title)
            .font(.title3.bold())
            .foregroundColor(.white)
        Spacer()
        Text("See all")
            .foregroundColor(.gray)
    }
}

#Preview {
    ActionButton(title: "mm", icon: "heart")
}
