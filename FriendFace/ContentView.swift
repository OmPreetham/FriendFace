//
//  ContentView.swift
//  FriendFace
//
//  Created by Om Preetham Bandi on 6/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
        
    var body: some View {
        NavigationStack {
            List(users, id: \.id) { user in
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
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            let userDecoder = JSONDecoder()
            
            userDecoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? userDecoder.decode([User].self, from: data) {
                users = decodedResponse
            } else {
                print("Failed to decode JSON")
            }
        } catch {
            print("Invalid data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
