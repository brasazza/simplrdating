//
//  SettingsView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 11/08/23.
//

import SwiftUI

struct SettingsView: View {
    // Example state values; you'd likely have actual data-bound values here
    @Environment(\.colorScheme) var colorScheme
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
                
                Text("Preferences")
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.5), radius: 10)

                
                Spacer()
                
                // Placeholder for symmetry.
                Spacer().frame(width: 40)
            }
            .padding(.vertical)
            
            // Age Range
            VStack(alignment: .leading, spacing: 10) {
                            Text("Age Range: \(Int(lowerAgeBound)) - \(Int(upperAgeBound))")
                            
                            HStack {
                                Text("18")
                                    .foregroundColor(.gray)
                                Slider(value: $lowerAgeBound, in: 18...upperAgeBound)
                                Slider(value: $upperAgeBound, in: lowerAgeBound...100)
                                Text("100")
                                    .foregroundColor(.gray)
                }
            }
            
            Spacer().frame(height: 30)

            // Distance Range
            VStack(alignment: .leading, spacing: 10) {
                Text("Maximum Distance: \(Int(distance)) km")
                Slider(value: $distance, in: 5...200)
            }
            
            Spacer().frame(height: 30)

            // Show Me
            Picker("Show Me", selection: $showMe) {
                Text("Men").tag("Men")
                Text("Women").tag("Women")
                Text("Everyone").tag("Everyone")
            }.pickerStyle(SegmentedPickerStyle())

            Spacer().frame(height: 30)

            // Notifications, Profile Visibility, etc...
            Toggle("Match Notifications", isOn: .constant(true))
                .toggleStyle(SwitchToggleStyle(tint: colorScheme == .dark ? Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 1) : Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 1)))

            Toggle("Message Notifications", isOn: .constant(true))
                .toggleStyle(SwitchToggleStyle(tint: colorScheme == .dark ? Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 1) : Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 1)))

            Toggle("Profile Visibility", isOn: .constant(true))
                .toggleStyle(SwitchToggleStyle(tint: colorScheme == .dark ? Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 1) : Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 1)))



            Spacer()

            // Log Out & Delete Account
            Button(action: {
                // Log Out logic
            }) {
                Text("Log Out")
                    .fontWeight(.semibold)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .padding()
                    .frame(width: 200)
                    .background {
                        Capsule()
                            .fill(colorScheme == .dark ? Color(red: 221/255, green: 0/255, blue: 0/255) : Color(red: 221/255, green: 0/255, blue: 0/255))
                    }
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 5)
            }
            
            Spacer().frame(height: 12)

            Button(action: {
                // Delete Account logic
            }) {
                Text("Delete Account")
                    .fontWeight(.semibold)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .padding()
                    .frame(width: 200)
                    .background {
                        Capsule()
                            .fill(colorScheme == .dark ? Color.gray : Color.gray)
                    }
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 5)
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


