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
        NavigationStack {
            VStack(spacing: 20) {
               
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                    .padding(.top, 50)
                
             
                Text(viewModel.currentUserName.isEmpty ? "User" : viewModel.currentUserName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.2))
                
               
                Text(viewModel.currentUserEmail)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                List {
                    Section(header: Text("Account")) {
                        // Navigasi ke Edit Profile
                        NavigationLink(destination: EditProfileView()) {
                            HStack {
                                Image(systemName: "pencil.circle")
                                    .foregroundColor(.blue)
                                Text("Edit Profile")
                            }
                        }
                        
                      
                        
                        HStack {
                            Image(systemName: "gearshape")
                                .foregroundColor(.gray)
                            Text("Settings")
                        }
                    }
                    
                    Section {
                        
                        Button(action: {
                            viewModel.logout()
                        }) {
                            HStack {
                                Image(systemName: "arrow.right.square")
                                Text("Log Out")
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppViewModel())
}
