//
//  SwipingView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 09/08/23.
//

import SwiftUI

struct SwipingView: View {
    @State private var profiles: [Profile] = [
        Profile(id: 1, imageName: "profile1"),
        Profile(id: 2, imageName: "profile2"),
        Profile(id: 3, imageName: "profile3"),
        // ... add more profiles as needed
    ]
    @State private var translation: CGSize = .zero

    var body: some View {
        VStack {
            ZStack {
                ForEach(profiles, id: \.id) { profile in
                    // Check if the current profile is the last one in the array
                    if profile == profiles.last {
                        ProfileCard(profile: profile)
                            .offset(x: translation.width, y: 0) // Only allow horizontal movement
                            .rotationEffect(.degrees(Double(translation.width / 10))) // Adjust rotation based on swipe distance
                            .animation(.interactiveSpring, value: 1.0)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        translation = gesture.translation
                                    }
                                    .onEnded { _ in
                                        handleSwipe()
                                    }
                            )
                    } else {
                        // Display other cards in the stack without the gesture
                        ProfileCard(profile: profile)
                    }
                }
            }
        }
        .padding()
        
        Spacer()
        
        BottomNavBar()
            .padding(.bottom)
    }

    func handleSwipe() {
        if translation.width < -100 {
            // Swipe left (dislike)
            profiles.removeLast()
        } else if translation.width > 100 {
            // Swipe right (like)
            profiles.removeLast()
        }
        translation = .zero
    }
}

struct ProfileCard: View {
    var profile: Profile

    var body: some View {
        Image(profile.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 400)
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.4)]), startPoint: .center, endPoint: .bottom)
            )
    }
}

struct BottomNavBar: View {
    var body: some View {
        HStack {
            Button(action: {
                // Dislike action
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
            
            Spacer()

            Button(action: {
                // Refresh action
            }) {
                Image(systemName: "arrow.clockwise")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }

            Spacer()

            Button(action: {
                // Like action
            }) {
                Image(systemName: "heart.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.green)
            }
        }
        .padding(.horizontal)
    }
}

struct Profile: Identifiable, Equatable {
    var id: Int
    var imageName: String
}

struct SwipingView_Previews: PreviewProvider {
    static var previews: some View {
        SwipingView()
            .frame(width: 430, height: 932)  // iPhone X dimensions as an example
            .previewLayout(.sizeThatFits)
    }
}


