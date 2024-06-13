//
//  DetailView.swift
//  FriendFace
//
//  Created by Om Preetham Bandi on 6/13/24.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        NavigationStack {
            List {
                Section("About") {
                    Text(user.about)
                }
                
                Section("Basic Details") {
                    Text("Registered: \(user.registered.formatted(date: .abbreviated, time: .shortened))")
                    Text("Age: \(user.age)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                    Text("Works for: \(user.company)")
                }
                
                Section("Friends") {
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                }
                
                Section("Tags") {
                    ForEach(user.tags, id: \.self) { tag in
                        Text(tag)
                    }
                }
            }
            .navigationTitle(user.name)
        }
    }
}

#Preview {
    DetailView(user:  User(
        id: UUID(),
        isActive: false,
        name: "Alford Rodriguez",
        age: 21,
        company: "Imkan",
        email: "alfordrodriguez@imkan.com",
        address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
        about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt.",
        registered: Date(),
        tags: ["cillum", "consequat", "deserunt"],
        friends: [
            Friend(id: UUID(), name: "Hawkins Patel"),
            Friend(id: UUID(), name: "Jewel Sexton")
        ]
    ))
}
