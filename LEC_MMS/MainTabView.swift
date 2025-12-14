//
//  MainTabView.swift
//  LEC_MMS
//
//  Created by Ayonima on 12/14/25.
//


import SwiftUI

struct MainTabView: View {
    @State private var showPostJobModal = false
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ActivityView()
                .tabItem {
                    Image(systemName: "doc.text.magnifyingglass")
                    Text("My Activity")
                }
            
            Text("")
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Post")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .onChange(of: showPostJobModal) { _ in }
        .overlay(
            Button(action: {
                showPostJobModal = true
            }) {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .offset(y: -20)
            , alignment: .bottom
        )
        .sheet(isPresented: $showPostJobModal) {
            PostJobView()
        }
    }
}