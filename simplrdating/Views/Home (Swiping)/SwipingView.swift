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
        NavigationView {
            VStack {
                ZStack {
                    Text("simplr.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            // Navigate to Settings
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing)
                    }
                }
                
                Spacer()
                
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
                .frame(height:400)
                .padding()
                
                Spacer()
                
                BottomNavBar()
                    .padding(.bottom)
            }
        }
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
        HStack(spacing: 50) {  // Adjust the spacing value as needed
            Button(action: {
                // Navigate to Profile
            }) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }

            Button(action: {
                // Navigate to Main Swiping Area
            }) {
                Image(systemName: "flame.fill")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }

            NavigationLink(destination: MatchesView()) {
                Image(systemName: "message.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }
}

struct Profile: Identifiable, Equatable {
    var id: Int
    var imageName: String
}

//struct SwipingView_Previews: PreviewProvider {
//    static var previews: some View {
        
//        VStack {
//            SwipingView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
//                .previewDisplayName("iPhone 14")
//        }
//    }
//}

#Preview {
    SwipingView()
}
