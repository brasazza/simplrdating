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
    
    var body: some View {
        VStack {
            Text(username)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.5), radius: 10)
            
            Spacer()
            
            VStack {
                Image("profile3") // Imagen de referencia para la foto principal
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3), radius: 20)

            
            Spacer()
                        
                        VStack(spacing: 10) {
                            Button(action: {
                                // Edit Media Action
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
                            }
                    
                        }
                        .padding(.bottom)
                    }
                    .padding()
                }
            }

//#Preview {
//    ProfileView(username: "User123")
//}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
