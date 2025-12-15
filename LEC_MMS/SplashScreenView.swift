//
//  SplashScreenView.swift
//  LEC_MMS
//
//  Created by Ayonima on 12/14/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        VStack {
            VStack {
                Image("KerjaYuk")
                    .resizable()        
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text("KerjaYuk")
                    .font(Font.custom("Baskerville-Bold", size: 26))
                    .foregroundColor(.black.opacity(0.80))
                    .padding(.top, 10)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.size = 0.9
                    self.opacity = 1.00
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
