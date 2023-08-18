//
//  MatchesView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 11/08/23.
//

import SwiftUI

struct MatchesView: View {
    // Dummy data for now
    @Environment(\.colorScheme) var colorScheme
    @State private var matchedProfiles: [Profile] = [
        Profile(id: 1, imageName: "profile1"),
        Profile(id: 2, imageName: "profile2"),
        Profile(id: 3, imageName: "profile3"),
        Profile(id: 4, imageName: "profile4"),
        Profile(id: 5, imageName: "profile5"),
        Profile(id: 6, imageName: "profile6"),
        Profile(id: 7, imageName: "profile7"),
        Profile(id: 8, imageName: "profile8"),
        // ... add more profiles as needed
    ]
    
    @State private var selectedProfileImage: String = ""
    @State private var showChatView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                if matchedProfiles.isEmpty {
                    Spacer()
                    Text("No matches yet. Keep swiping!")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                        ForEach(matchedProfiles, id: \.id) { profile in
                            Image(profile.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 0.1))
                                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.5), radius: 10)
                                .onTapGesture {
                                    selectedProfileImage = profile.imageName
                                    showChatView = true
                                }
                        }
                    }
                    .padding()
                }
                
                Spacer()
                Button(action: {
                    // Refresh action
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .padding(.bottom)
            }
            
            if showChatView {
                ChatView(imageName: selectedProfileImage)
                    .transition(.move(edge: .trailing))
            }
        }
    }
}

#Preview {
    MatchesView()
}
