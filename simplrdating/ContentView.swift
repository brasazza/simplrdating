//
//  ContentView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 09/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
