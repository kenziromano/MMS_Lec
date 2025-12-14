//
//  PostJobView.swift
//  LEC_MMS
//
//  Created by Ayonima on 12/14/25.
//


import SwiftUI

struct PostJobView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var priceString: String = ""
    @State private var location: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Job Details")) {
                    TextField("Job Title (e.g. Fix Kitchen Sink)", text: $title)
                    TextField("Location (e.g. Jakarta)", text: $location)
                    TextField("Budget (Rp)", text: $priceString)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(height: 100)
                    Text("Describe what needs to be done once.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Button(action: {
                    if let price = Int(priceString) {
                        viewModel.addJob(title: title, description: description, price: price, location: location)
                        dismiss()
                    }
                }) {
                    Text("Post Job Now")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle("Post a Job")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}