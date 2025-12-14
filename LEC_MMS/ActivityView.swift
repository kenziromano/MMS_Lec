//
//  ActivityView.swift
//  LEC_MMS
//
//  Created by Ayonima on 12/14/25.
//


import SwiftUI

struct ActivityView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            Text("Activity")
                .font(.headline)
                .padding()
            
            HStack {
                Button(action: { selectedTab = 0 }) {
                    VStack {
                        Text("My Applied Jobs")
                            .fontWeight(selectedTab == 0 ? .bold : .regular)
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(selectedTab == 0 ? .blue : .clear)
                    }
                }
                
                Button(action: { selectedTab = 1 }) {
                    VStack {
                        Text("My Listed Jobs")
                            .fontWeight(selectedTab == 1 ? .bold : .regular)
                            .foregroundColor(selectedTab == 1 ? .blue : .gray)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(selectedTab == 1 ? .blue : .clear)
                    }
                }
            }
            .frame(height: 40)
            
            ScrollView {
                if selectedTab == 0 {
                    if viewModel.myApplications.isEmpty {
                        EmptyStateView(text: "You haven't applied to any jobs yet.")
                    } else {
                        ForEach(viewModel.myApplications) { app in
                            ActivityCard(title: app.job.title, subtitle: app.job.location, status: app.status.rawValue, statusColor: getStatusColor(app.status))
                        }
                    }
                } else {
                    let myJobs = viewModel.jobs.filter { $0.postedByUserID == "me" }
                    if myJobs.isEmpty {
                        EmptyStateView(text: "You haven't posted any jobs yet.")
                    } else {
                        ForEach(myJobs) { job in
                            ActivityCard(title: job.title, subtitle: "Posted: Today", status: "Open", statusColor: .green)
                        }
                    }
                }
            }
            .background(Color(.systemGray6))
        }
    }
    
    func getStatusColor(_ status: ApplicationStatus) -> Color {
        switch status {
        case .pending: return .orange
        case .accepted: return .green
        case .rejected: return .red
        }
    }
}

struct ActivityCard: View {
    let title: String
    let subtitle: String
    let status: String
    let statusColor: Color
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay(Image(systemName: "doc.text").foregroundColor(.gray))
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(status)
                .font(.caption)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(statusColor.opacity(0.2))
                .foregroundColor(statusColor)
                .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

struct EmptyStateView: View {
    let text: String
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "tray")
                .font(.largeTitle)
                .foregroundColor(.gray)
                .padding()
            Text(text)
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(height: 300)
    }
}