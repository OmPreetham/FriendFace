//
//  DetailView.swift
//  FriendFace
//
//  Created by Om Preetham Bandi on 6/13/24.
//

import SwiftUI
import SwiftData

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

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: User.self, configurations: config)
//        let user = User(
//            id: "24232",
//            isActive: false,
//            name: "Alford Rodriguez",
//            age: 21,
//            company: "Imkan",
//            email: "alfordrodriguez@imkan.com",
//            address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
//            about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt.",
//            registered: Date(),
//            tags: ["cillum", "consequat", "deserunt"],
//            friends: [
//                Friend(id: "32r23", name: "Hawkins Patel"),
//                Friend(id: "22323", name: "Jewel Sexton")
//            ]
//        )
//        return DetailView(user: user)
//            .modelContainer(container)
//    } catch {
//        return Text("Failed to create container: \(error.localizedDescription)")
//    }
//}
