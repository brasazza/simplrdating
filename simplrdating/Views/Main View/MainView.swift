//
//  MainView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 11/08/23.
//

import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab: Int = 0
    @State private var isShowingSettings: Bool = false

    var body: some View {
        ZStack {
            // Content for main app
            if !isShowingSettings {
                VStack(spacing: 0) {
                    TopNavBar(isShowingSettings: $isShowingSettings)
                    
                    switch selectedTab {
                    case 0:
                        ProfileView()
                    case 1:
                        SwipingView()
                    case 2:
                        MatchesView()
                    default:
                        Text("Other views can be added here.")
                    }
                    
                    BottomNavBar(selectedTab: $selectedTab)
                }
            }

            // Settings View
            if isShowingSettings {
                SettingsView(isShowingSettings: $isShowingSettings)
            }
        }
    }
}

struct TopNavBar: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isShowingSettings: Bool
    
    var body: some View {
        ZStack {
            Text("simpl.")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                Spacer()
                
                Button(action: {
                    isShowingSettings.toggle()
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.4), radius: 5)
                }
                .padding(.trailing, 20)
            }
        }
    }
}

struct BottomNavBar: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 50) {
            Button(action: {
                selectedTab = 0
            }) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(selectedTab == 0 ? .blue : .gray)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.4), radius: 10)
            }

            Button(action: {
                selectedTab = 1
            }) {
                Image(systemName: "flame.fill")
                    .font(.largeTitle)
                    .foregroundColor(selectedTab == 1 ? .red : .gray)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.4), radius: 10)
            }

            Button(action: {
                selectedTab = 2
            }) {
                Image(systemName: "message.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(selectedTab == 2 ? .blue : .gray)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.4), radius: 10)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MainView()
}
