//
//  MatchesView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 11/08/23.
//

import SwiftUI

struct MatchesView: View {
    // Dummy data for now
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
                                .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1))
                                .shadow(radius: 5)
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
            .background(
                NavigationLink(
                    "",
                    destination: ChatView(imageName: selectedProfileImage),
                    isActive: $showChatView
                )
                .hidden()
            )
    }
}

#Preview {
    MatchesView()
}



