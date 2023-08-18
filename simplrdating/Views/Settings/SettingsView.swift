//
//  PreferencesView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 11/08/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var ageRange: ClosedRange<Double> = 20...30
    @State private var distance: Double = 50
    @State private var showMe: String = "Everyone"
    @State private var lowerAgeBound: Double = 20
    @State private var upperAgeBound: Double = 30
    @State private var emailNotification: Bool = true
    @State private var pushNotification: Bool = true
    @State private var smsNotification: Bool = true
    @State private var showMeToggle: Bool = true
    @State private var goGlobalToggle: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .top) {
            Form {
                Section(header: Text("Visibility Preferences")) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Age Range: \(Int(lowerAgeBound)) - \(Int(upperAgeBound))")
                        HStack {
                            Text("18")
                                .foregroundColor(.gray)
                            Slider(value: $lowerAgeBound, in: 18...upperAgeBound)
                            Slider(value: $upperAgeBound, in: lowerAgeBound...30)
                            Text("30")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Maximum Distance: \(Int(distance)) miles")
                        Slider(value: $distance, in: 1...100)
                    }
                    
                    Picker("Show me", selection: $showMe) {
                        Text("Everyone").tag("Everyone")
                        Text("Men").tag("Men")
                        Text("Women").tag("Women")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Toggle("Show me?", isOn: $showMeToggle)
                        .toggleStyle(SwitchToggleStyle(tint: colorScheme == .dark ? Color.gray : Color.black))
                    Toggle("Go Global", isOn: $goGlobalToggle)
                        .toggleStyle(SwitchToggleStyle(tint: colorScheme == .dark ? Color.gray : Color.black))
                }
                
                Section(header: Text("Notifications")) {
                    Toggle("Email", isOn: $emailNotification)
                        .toggleStyle(SwitchToggleStyle(tint: colorScheme == .dark ? Color.gray : Color.black))
                    Toggle("Push Notifications", isOn: $pushNotification)
                        .toggleStyle(SwitchToggleStyle(tint: colorScheme == .dark ? Color.gray : Color.black))
                    Toggle("SMS", isOn: $smsNotification)
                        .toggleStyle(SwitchToggleStyle(tint: colorScheme == .dark ? Color.gray : Color.black))
                }
                
                Section(header: Text("Account Options")) {
                    Button("Log out", action: {})
                        .frame(maxWidth: .infinity, alignment: .center)
                    Button("Restore Purchases", action: {})
                        .frame(maxWidth: .infinity, alignment: .center)
                    Button("Delete Account", action: {})
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding(.top)
            .padding(.top)
            .padding(.top, 10)
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()  // Dismiss the SettingsView to go back
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(colorScheme == .dark ? .white : .gray)
                    }
                    .padding(.leading, 15)
                    
                    Spacer()
                    
                    Text("Settings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Spacer()
                    
                    // Placeholder for symmetry.
                    Spacer().frame(width: 35)
                }
                .padding(.vertical, 8)
                .background(colorScheme == .dark ? Color.black : Color(UIColor.systemBackground))
                .shadow(color: colorScheme == .dark ? .clear : .gray, radius: 2, x: 0, y: 2)
                
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


#Preview {
    SettingsView()
}

