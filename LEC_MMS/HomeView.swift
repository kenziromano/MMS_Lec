import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Find One-Off Jobs")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Work securely, get paid instantly.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .frame(height: 160)
                            .cornerRadius(20)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Butuh Uang Cepat?")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Selesaikan tugas hari ini, cair hari ini.")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    LazyVStack(spacing: 15) {
                        ForEach(viewModel.jobs, id: \.self) { job in
                            NavigationLink(destination: JobDetailView(job: job)) {
                                JobCard(job: job)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 80)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct JobCard: View {
    let job: Job
    
    var body: some View {
        HStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue.opacity(0.1))
                .frame(width: 60, height: 60)
                .overlay(Image(systemName: "briefcase.fill").foregroundColor(.blue))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(job.title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                Text(job.location)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("Rp \(job.price)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.top, 2)
            }
            Spacer()
            
            Text("One-Time")
                .font(.caption2)
                .padding(6)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
