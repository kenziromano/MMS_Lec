//
//  JobDetailView.swift
//  LEC_MMS
//
//  Created by Ayonima on 12/14/25.
//


import SwiftUI

struct JobDetailView: View {
    let job: Job
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 200)
                .overlay(Image(systemName: "photo").font(.largeTitle).foregroundColor(.gray))
            
            VStack(alignment: .leading, spacing: 15) {
                Text(job.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    Label(job.location, systemImage: "mappin.and.ellipse")
                    Spacer()
                    Text("Rp \(job.price)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .foregroundColor(.gray)
                
                Divider()
                
                Text("Job Description")
                    .font(.headline)
                Text(job.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button(action: {
                    viewModel.applyToJob(job: job)
                    dismiss()
                }) {
                    Text("Apply Now")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .ignoresSafeArea(edges: .top)
    }
}