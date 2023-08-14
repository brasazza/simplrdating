//
//  Home.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 09/08/23.
//

import SwiftUI

struct Home: View {
    /// View Properties
    @Environment(\.colorScheme) var colorScheme
    @State private var activeIntro: PageIntro = pageIntros[0]
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var keyboardHeight: CGFloat = 0

    var body: some View {
        GeometryReader {
            let size = $0.size
            
            IntroView(intro: $activeIntro, size: size) {
                /// User Login/Signup View
                VStack(spacing: 10) {
                    
                    Button {
                                            
                    } label: {
                        HStack {
                            Image("googlelogo")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Text("Sign Up with Google")
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background {
                            Capsule()
                                .fill(colorScheme == .dark ? Color.black : Color.white)
                                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 5)
                        }
                    }
                    
                    Button {
                                            
                    } label: {
                        HStack {
                            Image(systemName: "apple.logo")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Text("Sign Up with Apple")
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background {
                            Capsule()
                                .fill(colorScheme == .dark ? Color.black : Color.white)
                                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 5)
                        }
                    }
                    
                    Spacer(minLength: 10)

                    /// Custom TextField
                    CustomTextField(text: $emailID, hint: "Email Address", leadingIcon: Image(systemName: "envelope"))
                    CustomTextField(text: $password, hint: "Password", leadingIcon: Image(systemName: "lock"), isPassword: true)
                    
                    Spacer(minLength: 10)
                    
                    Button {
                        
                    } label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background {
                                Capsule()
                                    .fill(colorScheme == .dark ? Color.white : Color.black)
                            }
                            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 10)
                    }
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Text("You already have an account? ")
                            .font(.caption)
                            .foregroundColor(colorScheme == .dark ? .white : .gray)

                        NavigationLink(destination: LoginView()) {
                            Text("Log In")
                                .font(.caption)
                                .foregroundColor(Color.blue)
                                .underline()
                        }
                    }

                }
                .padding(.top, 25)
            }
        }
        .padding(15)
        /// Manual Keyboard Push
        .offset(y: -keyboardHeight)
        /// Disabling Native Keyboard Push
        .ignoresSafeArea(.keyboard, edges: .all)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { output in
            if let info = output.userInfo, let height = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                keyboardHeight = height
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            keyboardHeight = 0
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0), value: keyboardHeight)
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

/// Intro View
struct IntroView<ActionView: View>: View {
    @Binding var intro: PageIntro
    @Environment(\.colorScheme) var colorScheme
    var size: CGSize
    var actionView: ActionView
    
    init(intro: Binding<PageIntro>, size: CGSize, @ViewBuilder actionView: @escaping () -> ActionView) {
        self._intro = intro
        self.size = size
        self.actionView = actionView()
    }
    
    /// Animation Properties
    @State private var showView: Bool = false
    @State private var hideWholeView: Bool = false
    var body: some View {
        VStack {
            /// Image View
            GeometryReader {
                let size = $0.size
                
                Image(intro.introAssetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3), radius: 20)

            }
            /// Moving Up
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 2 : 0)
            
            /// Tile & Action's
            VStack(alignment: .center, spacing: 10) {
                Spacer(minLength: 0)
                
                Text(intro.title)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .multilineTextAlignment(.center)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 20)
                
                
                Text(intro.subTitle)
                    .font(.headline)
                    .foregroundColor(colorScheme == .dark ? .white : .gray)
                    .multilineTextAlignment(.center)
                    .padding(.top, 15)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 20)

                if !intro.displaysAction {
                    Group {
                        Spacer(minLength: 25)
                        
                        /// Custom Indicator View
                        CustomIndicatorView(totalPages: filteredPages.count, currentPage: filteredPages.firstIndex(of: intro) ?? 0)
                            .frame(maxWidth: .infinity)
                        
                        Spacer(minLength: 10)
                        
                        Button {
                            changeIntro()
                        } label: {
                            Text("Next")
                               .fontWeight(.semibold)
                               .foregroundColor(Color(.black))
                               .frame(width: size.width * 0.4)
                               .padding(.vertical, 15)
                               .background {
                                   Capsule()
                               .fill(
                                   LinearGradient(
                                       gradient: Gradient(colors: [
                                           colorScheme == .dark ? Color(red: 242/255, green: 242/255, blue: 247/255) : Color(red: 242/255, green: 242/255, blue: 247/255),
                                           Color.white
                                       ]),
                                       startPoint: .top,
                                       endPoint: .bottom
                                   )
                               )
                               .shadow(color: colorScheme == .dark ? Color.gray.opacity(0.3) : Color.white.opacity(0.7), radius: 5, x: -5, y: -5)
                              .shadow(color: colorScheme == .dark ? Color.white.opacity(0.4) : Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                              .overlay(
                                  Capsule()
                                      .stroke(
                                          LinearGradient(
                                              gradient: Gradient(colors: [
                                                  colorScheme == .dark ? Color.white.opacity(0.07) : Color.black.opacity(0.07),
                                                  Color.clear
                                              ]),
                                              startPoint: .top,
                                              endPoint: .bottom
                                          ),
                                          lineWidth: 0.5
                                      )
                              )

                               }
                        }
                        .frame(maxWidth: .infinity)
                    }
                } else {
                    /// Action View
                    actionView
                        .offset(y: showView ? 0 : size.height / 2)
                        .opacity(showView ? 1 : 0)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            /// Moving Down
            .offset(y: showView ? 0 : size.height / 2)
            .opacity(showView ? 1 : 0)
        }
        .offset(y: hideWholeView ? size.height / 2 : 0)
        .opacity(hideWholeView ? 0 : 1)
        /// Back Button
        .overlay(alignment: .topLeading) {
            /// Hiding it for Very First Page, Since there is no previous page present
            if intro != pageIntros.first {
                Button {
                    changeIntro(true)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .contentShape(Rectangle())
                }
                .padding(10)
                /// Animating Back Button
                /// Comes From Top When Active
                .offset(y: showView ? 0 : -200)
                /// Hides by Going back to Top When In Active
                .offset(y: hideWholeView ? -200 : 0)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
                showView = true
            }
        }
    }
    
    /// Updating Page Intro's
    func changeIntro(_ isPrevious: Bool = false) {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
            hideWholeView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            /// Updating Page
            if let index = pageIntros.firstIndex(of: intro), (isPrevious ? index != 0 : index != pageIntros.count - 1) {
                intro = isPrevious ? pageIntros[index - 1] : pageIntros[index + 1]
            } else {
                intro = isPrevious ? pageIntros[0] : pageIntros[pageIntros.count - 1]
            }
            /// Re-Animating as Split Page
            hideWholeView = false
            showView = false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
                showView = true
            }
        }
    }
    
    var filteredPages: [PageIntro] {
        return pageIntros.filter { !$0.displaysAction }
    }
}

#Preview {
    Home()
}
