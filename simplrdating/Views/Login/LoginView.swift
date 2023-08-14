
import SwiftUI

struct LoginView: View {
    /// View Properties
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .contentShape(Rectangle())
                    }
                    
                    Spacer()
                    
                }
                .padding(.bottom, 30)
                // Image, Title and Subtitle
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: 150, height: 150)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3), radius: 20)
                
                Text("Log In")
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .multilineTextAlignment(.center)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 20)
                
                Text("Log In Into Your Account")
                    .font(.headline)
                    .foregroundColor(colorScheme == .dark ? .white : .gray)
                    .multilineTextAlignment(.center)
                    .padding(.top, 15)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 20)
                
                Spacer().frame(height: 40)
                
                // Login with Google
                Button {
                    
                } label: {
                    HStack {
                        Image("googlelogo")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Text("Log In with Google")
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
                
                // Login with Apple
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "apple.logo")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Text("Log In with Apple")
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
                
                // Email and Password fields
                CustomTextField(text: $emailID, hint: "Email Address", leadingIcon: Image(systemName: "envelope.fill"))
                    .padding(.top, 25)
                
                CustomTextField(text: $password, hint: "Password", leadingIcon: Image(systemName: "lock.fill"), isPassword: true)
                    .padding(.top, 15)
                
                // Log In button
                Button(action: {
                    
                }, label: {
                    Text("Log In")
                        .fontWeight(.semibold)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background {
                            Capsule()
                                .fill(colorScheme == .dark ? Color.white : Color.black)
                        }
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 10)
                })
                .padding(.top, 15)
                
                Spacer()
                
                HStack(spacing: 0) {
                    Text("You do not have an account? ")
                        .font(.caption)
                        .foregroundColor(colorScheme == .dark ? .white : .gray)
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Sign Up")
                            .font(.caption)
                            .foregroundColor(Color.blue)
                            .underline()
                    }
                }
            }
            .padding()
            
        }
    }
    
        struct LoginView_Previews: PreviewProvider {
            static var previews: some View {
                LoginView()
            }
        }
    }
