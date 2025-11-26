import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        // 1. Wrap everything in NavigationStack to enable navigation
        NavigationStack {
            VStack {
                Spacer()
                
                // HEADERS
                VStack(spacing: 10) {
                    Text("Welcome Back")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.2))
                    
                    Text("Log in to see who is hiring or working around you today.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                .padding(.bottom, 40)
                
                // INPUT FIELDS
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.2))
                        
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.2))
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("Password", text: $password)
                            } else {
                                SecureField("Password", text: $password)
                            }
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer().frame(height: 40)
                
                Button(action: {
                    print("Login tapped!")
                }) {
                    Text("LOGIN")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.1, green: 0.0, blue: 0.3))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // 2. NAVIGATION LINK (Connects to Sign Up)
                HStack {
                    Text("You don't have an account yet?")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    // This creates the link to the other page
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign up")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.1, green: 0.0, blue: 0.3))
                    }
                }
                .padding(.bottom, 20)
            }
            .background(Color.white)
        }
    }
}

#Preview {
    ContentView()
}
