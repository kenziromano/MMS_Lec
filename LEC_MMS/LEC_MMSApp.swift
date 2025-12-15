//
//  LEC_MMSApp.swift
//  LEC_MMS
//
//  Created by Ayonima on 11/25/25.
//

import SwiftUI

@main
struct LEC_MMSApp: App {
    @StateObject private var appViewModel = AppViewModel()
    
    // State untuk mengontrol status splash screen
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreenView()
                    // Transisi saat splash screen hilang
                    .transition(.opacity)
                    .onAppear {
                        // Tunda selama 2 detik, lalu sembunyikan splash screen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                // Logika navigasi utama (Login vs Home)
                if appViewModel.isLoggedIn {
                    MainTabView()
                        .environmentObject(appViewModel)
                } else {
                    ContentView()
                        .environmentObject(appViewModel)
                }
            }
        }
    }
}
