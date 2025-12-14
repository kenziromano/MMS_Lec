//
//  SharedDataModel.swift
//  LEC_MMS
//
//  Created by Ayonima on 12/14/25.
//

import SwiftUI
import Foundation

struct Job: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let price: Int
    let location: String
    let category: String
    var postedByUserID: String
    var status: JobStatus
    var date: Date
}

enum JobStatus: String, Codable {
    case open = "Open"
    case inProgress = "In Progress"
    case completed = "Completed"
}

struct Application: Identifiable {
    let id = UUID()
    let job: Job
    let status: ApplicationStatus
    let date: Date
}

enum ApplicationStatus: String {
    case pending = "Pending"
    case accepted = "Accepted"
    case rejected = "Rejected"
}

class AppViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUserEmail: String = ""
    
    @Published var jobs: [Job] = [
        Job(title: "Potong Rumput Halaman", description: "Halaman sekitar 50m2, butuh mesin sendiri.", price: 150000, location: "Jakarta Selatan", category: "Gardening", postedByUserID: "other", status: .open, date: Date()),
        Job(title: "Bantu Pindahan Kos", description: "Angkat lemari dan kasur ke lantai 2.", price: 300000, location: "Bandung", category: "Moving", postedByUserID: "other", status: .open, date: Date()),
        
    ]
    
    @Published var myApplications: [Application] = []
    
    func login(email: String) {
        self.currentUserEmail = email
        self.isLoggedIn = true
    }
    
    func logout() {
        self.isLoggedIn = false
        self.currentUserEmail = ""
    }
    
    func addJob(title: String, description: String, price: Int, location: String) {
        let newJob = Job(title: title, description: description, price: price, location: location, category: "General", postedByUserID: "me", status: .open, date: Date())
        jobs.insert(newJob, at: 0)
    }
    
    func applyToJob(job: Job) {
        let application = Application(job: job, status: .pending, date: Date())
        myApplications.append(application)
    }
}
