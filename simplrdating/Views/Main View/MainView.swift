//
//  MainView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 11/08/23.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            
            TopNavBar()  // <-- Add this here

            // Content
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
            
            // Custom Bottom Navigation
            BottomNavBar(selectedTab: $selectedTab)
        }
    }
}

struct TopNavBar: View {
    @State private var isShowingSettings: Bool = false
    
    var body: some View {
        ZStack {
            Text("simplr.")
                .font(.largeTitle)
                .fontWeight(.bold)
            
//            HStack {
//                Spacer()
//                
//                NavigationLink(
//                    destination: SettingsView(),
//                    isActive: $isShowingSettings,
//                    label: {
//                        Image(systemName: "gearshape.fill")
//                            .font(.title)
//                            .foregroundColor(.gray)
//                    })
//                .isDetailLink(false)
//                .padding(.trailing)
//            }
        }
    }
}


struct BottomNavBar: View {
    @Binding var selectedTab: Int
    
   var body: some View {
       HStack(spacing: 50) {  // Adjust the spacing value as needed
           Button(action: {
               selectedTab = 0
           }) {
               Image(systemName: "person.crop.circle.fill")
                   .font(.largeTitle)
                   .foregroundColor(selectedTab == 0 ? .blue : .gray)
           }

           Button(action: {
               selectedTab = 1
           }) {
               Image(systemName: "flame.fill")
                   .font(.largeTitle)
                   .foregroundColor(selectedTab == 1 ? .red : .gray)
           }

           Button(action: {
               selectedTab = 2
           }) {
               Image(systemName: "message.circle.fill")
                   .font(.largeTitle)
                   .foregroundColor(selectedTab == 2 ? .blue : .gray)
           }
       }
       .padding(.horizontal)
   }
}

#Preview {
    MainView()
}
