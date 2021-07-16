//
//  ContentVM.swift
//  AsyncAwait
//
//  Created by Prashant Gaikwad on 16/07/21.
//

import Foundation

class ContentVM: ObservableObject {
    
    @Published var users: [User] = []
    
    func fetchAllUsers() {
        WebService().fetchUsers { result in
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getAllUsers() async {
        do {
            let userData = try await WebService().getUsers()
            DispatchQueue.main.async {
                self.users = userData
            }
        }catch {
            print(error)
        }
        
    }
}
