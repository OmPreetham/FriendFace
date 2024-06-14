//
//  ContentView.swift
//  FriendFace
//
//  Created by Om Preetham Bandi on 6/13/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) var users: [User]
    
    @State private var isLoading = false
        
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                    HStack {
                        Text(user.name)
                            .font(.headline)
                        Spacer()
                        Text(user.isActive ? "Active" : "Inactive")
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                }

            }
            .navigationTitle("FriendFace")
            .task {
                if users.isEmpty {
                    await loadData()
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Delete", systemImage: "trash") {
                       try? modelContext.delete(model: User.self)
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Button("Refresh") {
                        refreshData()
                    }
                }
            }
            .overlay {
                 if isLoading {
                     ProgressView("Loading...")
                 }
             }
        }
    }
    
    private func refreshData() {
        isLoading = true
        Task {
            do {
                try modelContext.delete(model: User.self)
                await loadData()
            } catch {
                print("Failed to delete data: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
    
    private func loadData() async {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print("invalid url")
                return
            }

            do {
                let (responseData, _) = try await URLSession.shared.data(from: url)

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                if let decodedResponse = try decoder.decode([User]?.self, from: responseData) {
                    for user in decodedResponse {
                        modelContext.insert(user)
                    }
                } else {
                    print("if let block not working")
                }

            } catch {
                print(error.localizedDescription)
                print(String(describing: error))
            }
        }
}

#Preview {
    ContentView()
}
