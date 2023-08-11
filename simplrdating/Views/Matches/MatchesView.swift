//
//  MatchesView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 11/08/23.
//

import SwiftUI

struct MatchesView: View {
    // Dummy data for now, you can replace this with actual data from your backend later
    @State private var matchedProfiles: [Profile] = [
        Profile(id: 1, imageName: "profile1"),
        Profile(id: 2, imageName: "profile2"),
        Profile(id: 3, imageName: "profile3"),
        // ... add more profiles as needed
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Matches")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
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
                                .onTapGesture {
                                    // Navigate to chat with the selected matched profile
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
        }
    }
}

#Preview {
    MatchesView()
}

