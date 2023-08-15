//
//  ChatView.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 14/08/23.
//

import SwiftUI

struct ChatView: View {
    var imageName: String
    @State private var currentMessage: String = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(id: UUID(), content: "Hola guapo", isCurrentUser: false, imageName: "profile2"),
        ChatMessage(id: UUID(), content: "Mucho gusto desconocida.", isCurrentUser: true, imageName: "profile1"),
        ChatMessage(id: UUID(), content: "¿Qué haciendo?", isCurrentUser: false, imageName: "profile2"),
        ChatMessage(id: UUID(), content: "Programando una app con SwiftUI, ¿y tú?", isCurrentUser: true, imageName: "profile1")
    ]
// This will store all messages
    
    var body: some View {
        VStack(spacing: 15) {
            ScrollView {
                LazyVStack {
                    ForEach(messages, id: \.id) { message in
                        ChatRow(message: message)
                    }
                }
                .background(Color.white) // Ensure the ScrollView has a white background
            }
            .padding()
            
            HStack {
                TextField("Type a message", text: $currentMessage)
                    .padding(10) // Padding for the text inside
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(UIColor.secondarySystemBackground)) // Rounded background
                    )
                    .padding(.horizontal)
                    .overlay(
                        HStack {
                            Spacer()
                            if !currentMessage.isEmpty {
                                Button(action: sendMessage) {
                                    Image(systemName: "paperplane.fill") // SF Symbol for sending
                                        .font(.title2)
                                        .foregroundColor(.blue) // Blue color for the send icon, adjust as needed
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
            }
            .padding(.bottom)
        }
        .background(Color.white.ignoresSafeArea())  // Ensure the entire view has a white background
    }

    func sendMessage() {
            let newMessage = ChatMessage(id: UUID(), content: currentMessage, isCurrentUser: true, imageName: imageName) // Assuming every message you send is from current user for now
            messages.append(newMessage)
            currentMessage = ""
        }
    }

struct ChatRow: View {
    var message: ChatMessage
    
    var body: some View {
        HStack {
            if !message.isCurrentUser {
                Image(message.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            } else {
                Spacer()
            }
            
            Text(message.content)
                .padding()
                .background(message.isCurrentUser ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(message.isCurrentUser ? .white : .black)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            if message.isCurrentUser {
                Image(message.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            } else {
                Spacer()
            }
        }
    }
}

struct ChatMessage: Identifiable {
    let id: UUID
    let content: String
    let isCurrentUser: Bool  // Flag to check if the message is from the current user or not
    let imageName: String    // Representing the image of the sender
}

#Preview {
    ChatView(imageName: "profile1")
}

