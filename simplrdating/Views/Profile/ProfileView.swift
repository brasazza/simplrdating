//
//  ProfileView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 11/08/23.
//
import SwiftUI

struct ProfileView: View {
    @State private var username: String = "Diego Franco"
    
    var body: some View {
        VStack {
            Text(username)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Spacer()
            
            Image("profile3") // Placeholder image for the main photo
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 400)
                .cornerRadius(10)
                .shadow(radius: 5)
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.4)]), startPoint: .center, endPoint: .bottom)
                )
            
            Spacer()
                        
                        HStack(spacing: 10) {
                            Button(action: {
                                // Edit Media Action
                            }) {
                                Text("Edit Media")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                // Edit Preferences Action
                            }) {
                                Text("Edit Preferences")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.purple)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
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
