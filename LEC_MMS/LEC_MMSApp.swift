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
    
    var body: some Scene {
        WindowGroup {
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
