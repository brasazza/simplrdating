//
//  ProfileView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 11/08/23.
//
import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var username: String = "Diego Franco"
    @State private var scale: CGFloat = 1.0

    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.2), Color.white]), startPoint: .top, endPoint: .bottom)
                           .edgesIgnoringSafeArea(.all)

            VStack {
                VStack {
                    Image("profile3") // Imagen de referencia para la foto principal
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                }
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3), radius: 20)
                .padding(.top, 30)
                
                Text(username)
                    .font(.title2)
                    .fontWeight(.bold)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.5), radius: 10)

                Spacer()
                
                VStack(spacing: 10) {
                    Button(action: {
                        // Edit Media Action
                        self.scale = 0.9
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.scale = 1.0
                        }
                    }) {
                        Text("Edit Profile")
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .padding()
                            .frame(width: 200)
                            .background {
                                Capsule()
                                    .fill(colorScheme == .dark ? Color.white : Color.black)
                            }
                            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 5)
                            .scaleEffect(scale)
                    }
                }
                .padding(.bottom)
            }
            .padding()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
