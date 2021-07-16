//
//  ContentView.swift
//  AsyncAwait
//
//  Created by Prashant Gaikwad on 16/07/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var contentVM: ContentVM
    
    var body: some View {
        NavigationView {
            VStack {
                List(contentVM.users, id: \.id) { user in
                    Text("\(user.name)")
                }
            }
            .navigationTitle("Users")
        }.onAppear {
            // contentVM.fetchAllUsers()
            async {
                await contentVM.getAllUsers()
            }
        }
    }
}
