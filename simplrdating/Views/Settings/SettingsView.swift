//
//  SettingsView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 11/08/23.
//

import SwiftUI

struct SettingsView: View {
    // Example state values; you'd likely have actual data-bound values here
    @State private var ageRange: ClosedRange<Double> = 20...30
    @State private var distance: Double = 50
    @State private var showMe: String = "Everyone"
    @State private var lowerAgeBound: Double = 20
    @State private var upperAgeBound: Double = 30
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()  // Dismiss the SettingsView to go back
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .padding(.leading)
                
                Spacer()
                
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Placeholder for symmetry.
                Spacer().frame(width: 40)
            }
            .padding(.vertical)
            
            // Age Range
            VStack(alignment: .leading, spacing: 10) {
                Text("Age Range: \(Int(lowerAgeBound)) - \(Int(upperAgeBound))")
                
                HStack {
                    Slider(value: $lowerAgeBound, in: 18...upperAgeBound)
                    Slider(value: $upperAgeBound, in: lowerAgeBound...100)
                }
            }

            // Distance Range
            VStack(alignment: .leading, spacing: 10) {
                Text("Maximum Distance: \(Int(distance)) km")
                Slider(value: $distance, in: 5...200)
            }

            // Show Me
            Picker("Show Me", selection: $showMe) {
                Text("Men").tag("Men")
                Text("Women").tag("Women")
                Text("Everyone").tag("Everyone")
            }.pickerStyle(SegmentedPickerStyle())

            // Notifications, Profile Visibility, etc...
            Toggle("Match Notifications", isOn: .constant(true))
            Toggle("Message Notifications", isOn: .constant(true))
            Toggle("Profile Visibility", isOn: .constant(true))

            Spacer()

            // Log Out & Delete Account
            Button(action: {
                // Log Out logic
            }) {
                Text("Log Out")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Button(action: {
                // Delete Account logic
            }) {
                Text("Delete Account")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
