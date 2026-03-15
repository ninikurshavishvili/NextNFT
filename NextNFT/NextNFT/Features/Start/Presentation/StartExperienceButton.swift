//
//  StartExperienceButton.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 15.03.26.
//

import SwiftUI

struct StartExperienceButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text("Start experience")
                Text("7")
            }
        }
    }
}
