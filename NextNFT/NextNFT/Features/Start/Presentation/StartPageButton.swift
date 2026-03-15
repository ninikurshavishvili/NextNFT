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

struct GoogleButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("G")
        }
    }
}

struct FacebookButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("f")
        }
    }
}

struct StartPageButtons: View {
    var body: some View {
        VStack(spacing: 0) {
           
            VStack(spacing: 20) {
                
                HStack(spacing: 15) {
                    Button("G") {
                        print("Google tapped")
                    }
                    .buttonStyle(.plain)
                    
                    Button("f") {
                        print("Facebook tapped")
                    }
                    .buttonStyle(.borderless)
                    
                    Spacer()
                    
                    Button {
                        print("Start experience tapped")
                    } label: {
                        HStack {
                            Text("Start experience")
                            Text("7")
                        }
                    }
                    .buttonStyle(.bordered)
                }
                
                HStack {
                    Text("Already have an account?")
                    
                    Button("Log in") {
                        print("Login tapped")
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }
}

#Preview {
    StartPageButtons()
}
