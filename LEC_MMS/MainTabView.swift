//
//  MainTabView.swift
//  LEC_MMS
//
//  Created by Ayonima on 12/14/25.
//

import SwiftUI

struct MainTabView: View {
    // State untuk mencatat tab mana yang aktif
    @State private var selectedTab: Int = 0
    // Untuk menyimpan tab terakhir sebelum tombol Post ditekan
    @State private var lastSelectedTab: Int = 0
    // Untuk memunculkan modal Post Job
    @State private var showPostJobModal = false
    
    var body: some View {
        // Menggunakan Binding custom untuk logic tombol Post
        TabView(selection: Binding(
            get: { selectedTab },
            set: { newValue in
                // Index 1 adalah posisi "Post"
                if newValue == 1 {
                    showPostJobModal = true
                    // Tetap di tab sebelumnya, jangan pindah ke layar kosong
                    selectedTab = lastSelectedTab
                } else {
                    // Pindah tab seperti biasa
                    selectedTab = newValue
                    lastSelectedTab = newValue
                }
            }
        )) {
            // Tab 1: Home (Index 0)
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            // Tab 2: Post (Index 1) - Tombol Aksi
            Text("") // View kosong, hanya pemicu
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Post")
                }
                .tag(1)
            
            // Tab 3: Activity (Index 2)
            ActivityView()
                .tabItem {
                    Image(systemName: "doc.text.magnifyingglass")
                    Text("Activity")
                }
                .tag(2)
            
            // Tab 4: Profile (Index 3)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
        }
        // Modal muncul saat tombol Post ditekan
        .sheet(isPresented: $showPostJobModal) {
            PostJobView()
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppViewModel())
}
