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
        Profile(id: 4, imageName: "profile4"),
        Profile(id: 5, imageName: "profile5"),
        Profile(id: 6, imageName: "profile6"),
        Profile(id: 7, imageName: "profile7"),
        Profile(id: 8, imageName: "profile8"),
        // ... add more profiles as needed
    ]
    @State private var translation: CGSize = .zero
    @State private var endTranslation: CGSize = .zero
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                ZStack {
                    ForEach(profiles.indices.reversed(), id: \.self) { index in
                        let profile = profiles[index]
                        
                        if profile == profiles.last {
                            ProfileCard(profile: profile)
                                .offset(x: translation.width + endTranslation.width, y: endTranslation.height)
                                .rotationEffect(.degrees(Double(translation.width / 10)))
                                .opacity(opacityForTopCard())
                                .scaleEffect(scaleForTopCard())
                                .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.6, blendDuration: 0), value: translation)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            translation = gesture.translation
                                        }
                                        .onEnded { value in
                                            handleSwipe(with: value)
                                        }
                                )
                                .zIndex(Double(index))
                        } else if profile == profiles[profiles.count - 2] {
                            ProfileCard(profile: profile)
                                .opacity(1.0)
                                .scaleEffect(1.0)
                                .offset(y: 0)
                                .animation(.easeInOut(duration: 0.4), value: profiles.count)
                                .zIndex(Double(index))
                        } else {
                            ProfileCard(profile: profile)
                                .opacity(0.85)
                                .scaleEffect(0.9)
                                .offset(y: -20)
                                .zIndex(Double(index))
                        }
                    }
                }
                .frame(height: 400)
                .padding()
                
                Spacer()
                
            }
        }
    }
    
    func opacityForTopCard() -> Double {
        let defaultOpacity: Double = 1.0
        let endOpacity: Double = 0.5
        let progress = abs(translation.width) / UIScreen.main.bounds.width
        return defaultOpacity - Double(progress) * (defaultOpacity - endOpacity)
    }
    
    func scaleForTopCard() -> CGFloat {
        let defaultScale: CGFloat = 1.0
        let endScale: CGFloat = 0.3
        
        let progress = abs(translation.width) / UIScreen.main.bounds.width
        return defaultScale - (progress * (defaultScale - endScale))
    }
    
    func handleSwipe(with gesture: DragGesture.Value) {
        let swipeThreshold: CGFloat = 80.0
        let swipeSpeedThreshold: CGFloat = 700.0
        
        if gesture.translation.width > swipeThreshold || gesture.predictedEndTranslation.width/0.3 > swipeSpeedThreshold {
            // Move card to Matches section of the bottom NavBar
            withAnimation {
                endTranslation = CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                profiles.removeLast()
                resetCardState()
            }
        } else if gesture.translation.width < -swipeThreshold || gesture.predictedEndTranslation.width/0.3 < -swipeSpeedThreshold {
            // "Putting into Trash" effect
            withAnimation {
                endTranslation = CGSize(width: -UIScreen.main.bounds.width, height: 0)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                profiles.removeLast()
                resetCardState()
            }
        } else {
            resetCardState()
        }
    }
    
    func resetCardState() {
        endTranslation = .zero
        translation = .zero
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
    
    // struct BottomNavBar: View {
    //    var body: some View {
    //        HStack(spacing: 50) {  // Adjust the spacing value as needed
    //            Button(action: {
    //                // Navigate to Profile
    //            }) {
    //                Image(systemName: "person.crop.circle.fill")
    //                    .font(.largeTitle)
    //                    .foregroundColor(.gray)
    //            }
    //
    //            Button(action: {
    //                // Navigate to Main Swiping Area
    //            }) {
    //                Image(systemName: "flame.fill")
    //                    .font(.largeTitle)
    //                    .foregroundColor(.red)
    //            }
    //
    //            NavigationLink(destination: MatchesView()) {
    //                Image(systemName: "message.circle.fill")
    //                    .font(.largeTitle)
    //                    .foregroundColor(.gray)
    //            }
    //        }
    //        .padding(.horizontal)
    //    }
    //}
    
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
    
    //#Preview {
    //    SwipingView()
    //}
    
}
