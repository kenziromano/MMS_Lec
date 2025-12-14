//
//  ProfileView.swift
//  LEC_MMS
//
//  Created by Ayonima on 12/14/25.
//


import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .padding(.top, 50)
            
            Text(viewModel.currentUserEmail)
                .font(.title2)
                .fontWeight(.bold)
            
            List {
                Section(header: Text("Account")) {
                    Text("Edit Profile")
                    Text("Payment Methods")
                    Text("Settings")
                }
                
                Section {
                    Button(action: {
                        viewModel.logout()
                    }) {
                        Text("Log Out")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}