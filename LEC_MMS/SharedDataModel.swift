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
    case pending = "Pending"
    case open = "Open"
    case inProgress = "In Progress"
    case completed = "Completed"
}

struct Application: Identifiable {
    let id = UUID()
    let job: Job
    var status: ApplicationStatus
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
    @Published var currentUserName: String = "User Baru"
    @Published var currentUserPassword: String = ""
    @Published var userBalance: Int = 10000
    
    @Published var jobs: [Job] = [
        Job(title: "Potong Rumput Halaman", description: "Halaman sekitar 50m2, butuh mesin sendiri.", price: 150000, location: "Jakarta Selatan", category: "Gardening", postedByUserID: "other", status: .open, date: Date()),
        Job(title: "Bantu Pindahan Kos", description: "Angkat lemari dan kasur ke lantai 2.", price: 300000, location: "Bandung", category: "Moving", postedByUserID: "other", status: .open, date: Date()),
    ]
    
    @Published var myApplications: [Application] = []
    
    init() {
        // Kita load data awal saat aplikasi baru dibuka (jika ada)
        let savedName = UserDefaults.standard.string(forKey: "savedName")
        if let name = savedName, !name.isEmpty {
            self.currentUserName = name
        }
    }
    
    
    func register(name: String, email: String, password: String) {
       
        UserDefaults.standard.set(name, forKey: "savedName")
        UserDefaults.standard.set(email, forKey: "savedEmail")
        UserDefaults.standard.set(password, forKey: "savedPassword")
        
        print("Register berhasil: \(name), \(email)")
       
    }
    

    func login(email: String) {
        self.currentUserEmail = email
        self.isLoggedIn = true
        
        // Cek data di penyimpanan
        let savedEmail = UserDefaults.standard.string(forKey: "savedEmail")
        let savedName = UserDefaults.standard.string(forKey: "savedName")
        
        // Jika email yang dimasukkan sama dengan email terakhir yang terdaftar/disimpan
        if savedEmail == email {
            // Muat namanya
            self.currentUserName = savedName ?? "User"
            self.currentUserPassword = UserDefaults.standard.string(forKey: "savedPassword") ?? ""
        } else {
            // Jika login pakai email asing, kita set default atau biarkan
            // (Dalam aplikasi nyata, ini akan ambil dari database)
            self.currentUserName = "User Baru"
        }
        
        // Simpan email sesi ini
        UserDefaults.standard.set(email, forKey: "savedEmail")
    }
    
    func logout() {
        self.isLoggedIn = false
        self.currentUserEmail = ""
        // Opsional: Reset nama jika ingin bersih saat logout
        // self.currentUserName = "User Baru"
    }
    
    func updateProfile(name: String, email: String, password: String) {
        self.currentUserName = name
        self.currentUserEmail = email
        
        if !password.isEmpty {
            self.currentUserPassword = password
            UserDefaults.standard.set(password, forKey: "savedPassword")
        }
        
        UserDefaults.standard.set(name, forKey: "savedName")
        UserDefaults.standard.set(email, forKey: "savedEmail")
    }
    
  
    
    func addJob(title: String, description: String, price: Int, location: String) -> Bool {
        if userBalance >= price {
            userBalance -= price
            
            let newJob = Job(title: title, description: description, price: price, location: location, category: "General", postedByUserID: "me", status: .pending, date: Date())
            jobs.insert(newJob, at: 0)
            
            let jobID = newJob.id
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
                guard let self = self else { return }
                if let index = self.jobs.firstIndex(where: { $0.id == jobID }) {
                    self.jobs[index].status = .open
                }
            }
            return true
        } else {
            return false
        }
    }
    
    func applyToJob(job: Job) {
        let application = Application(job: job, status: .pending, date: Date())
        myApplications.append(application)
        
        let appID = application.id
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            guard let self = self else { return }
            if let index = self.myApplications.firstIndex(where: { $0.id == appID }) {
                self.myApplications[index].status = .accepted
                self.userBalance += job.price
            }
        }
    }
}
