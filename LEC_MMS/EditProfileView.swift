//
//  EditProfileView.swift
//  LEC_MMS
//
//  Created by eslilinnn on 14/12/25.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Info Pribadi")) {
                VStack(alignment: .leading) {
                    Text("Nama Lengkap")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Nama Lengkap", text: $name)
                }
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
            }
            
            Section(header: Text("Keamanan")) {
                VStack(alignment: .leading) {
                    Text("Password Baru (Opsional)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    SecureField("Isi jika ingin mengganti password", text: $password)
                }
            }
            
            Button(action: {
                saveProfile()
            }) {
                Text("Simpan Perubahan")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
            }
        }
        .navigationTitle("Edit Profile")
        .onAppear {
            // Mengisi form dengan data yang sekarang ada di ViewModel
            name = viewModel.currentUserName
            email = viewModel.currentUserEmail
        }
        .alert("Berhasil", isPresented: $showAlert) {
            Button("OK") {
                dismiss() // Kembali ke halaman profile setelah simpan
            }
        } message: {
            Text("Data profil Anda telah diperbarui.")
        }
    }
    
    func saveProfile() {
        viewModel.updateProfile(name: name, email: email, password: password)
        showAlert = true
    }
}

#Preview {
    NavigationView {
        EditProfileView()
            .environmentObject(AppViewModel())
    }
}
