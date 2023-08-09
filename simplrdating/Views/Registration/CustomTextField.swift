//
//  CustomTextField.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 09/08/23.
//

import SwiftUI

struct CustomTextField: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var text: String
    var hint: String
    var leadingIcon: Image
    var isPassword: Bool = false

    var textFieldBackground: Color {
        colorScheme == .dark ? Color.gray.opacity(0.3) : Color.gray.opacity(0.1)
    }

    var iconAndHintColor: Color {
        colorScheme == .dark ? .white : .gray
    }

    var body: some View {
        HStack(spacing: -10) {
            leadingIcon
                .font(.callout)
                .foregroundColor(iconAndHintColor)
                .frame(width: 40, alignment: .leading)
            
            if isPassword {
                SecureField(hint, text: $text)
                    .foregroundColor(iconAndHintColor)
            } else {
                TextField(hint, text: $text)
                    .foregroundColor(iconAndHintColor)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(textFieldBackground)
        }
    }
}
