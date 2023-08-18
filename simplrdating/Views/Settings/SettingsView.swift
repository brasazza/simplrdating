//
//  PreferencesView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 11/08/23.
//

import SwiftUI

enum AppearanceMode: String, CaseIterable {
    case dark = "Dark Mode"
    case light = "Light Mode"
    case system = "System Default"
}

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isShowingSettings: Bool
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
    @State private var selectedTheme: AppearanceMode = .system

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

                    Picker("Show Me", selection: $showMe) {
                        Text("Everyone").tag("Everyone")
                        Text("Men").tag("Men")
                        Text("Women").tag("Women")
                    }
                    .pickerStyle(MenuPickerStyle())
                    
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

                Section(header: Text("Appearance")) {
                    Picker("Theme", selection: $selectedTheme) {
                        ForEach(AppearanceMode.allCases, id: \.self) { mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedTheme) {
                        let newValue = selectedTheme
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            switch newValue {
                            case .dark:
                                windowScene.windows.first?.overrideUserInterfaceStyle = .dark
                            case .light:
                                windowScene.windows.first?.overrideUserInterfaceStyle = .light
                            case .system:
                                windowScene.windows.first?.overrideUserInterfaceStyle = .unspecified
                            }
                        }
                    }
                }
                
                Section(header: Text("Account Options")) {
                    HStack {
                        Spacer()
                        Text("Log out")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Restore Purchases")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Delete Account")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }
            .padding(.top)
            .padding(.top)
            .padding(.top, 10)
            
            VStack {
               HStack {
                   Button(action: {
                       isShowingSettings = false
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
                    Spacer().frame(width: 30)
                }
                .padding(.vertical, 8)
                .background(colorScheme == .dark ? Color.black : Color(UIColor.systemBackground))
                .shadow(color: colorScheme == .dark ? .clear : .gray, radius: 2, x: 0, y: 2)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isShowingSettings: .constant(true))
    }
}
