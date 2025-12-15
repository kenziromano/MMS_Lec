import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showSuccessAlert: Bool = false

    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 10) {
                Text("Create an Account")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.2))
                
                Text("Connect with people nearby to get jobs done at a fixed price.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
            }
            .padding(.bottom, 40)
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Full name")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.2))
                    
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.words)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.2))
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
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
                if !name.isEmpty && !email.isEmpty && !password.isEmpty {
                    // 2. Panggil fungsi register untuk menyimpan data
                    viewModel.register(name: name, email: email, password: password)
                    
                    // Tampilkan alert sukses
                    showSuccessAlert = true
                }
            }) {
                Text("SIGN UP")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.1, green: 0.0, blue: 0.3))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .alert("Pendaftaran Berhasil", isPresented: $showSuccessAlert) {
                Button("OK") {
                
                    dismiss()
                }
            } message: {
                Text("Akun Anda telah berhasil dibuat. Silakan login menggunakan email dan password Anda.")
            }
            
            Spacer()
            
            HStack {
                Text("You don't have an account yet?")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Sign in")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.1, green: 0.0, blue: 0.3))
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignUpView()
        .environmentObject(AppViewModel())
}
