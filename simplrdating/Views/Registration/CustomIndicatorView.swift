//
//  CustomIndicatorView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 09/08/23.
//

import SwiftUI

struct CustomIndicatorView: View {
    /// View Properties
    @Environment(\.colorScheme) var colorScheme
    var totalPages: Int
    var currentPage: Int
    var activeTint: Color {
        colorScheme == .dark ? .white : .black
    }
    var inActiveTint: Color {
        colorScheme == .dark ? .white.opacity(0.5) : .gray.opacity(0.5)
    }

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) {
                Circle()
                    .fill(currentPage == $0 ? activeTint : inActiveTint)
                    .frame(width: 6, height: 6)
            }
        }
    }
}

struct CustomIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
