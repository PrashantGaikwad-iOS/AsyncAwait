//
//  WebService.swift
//  AsyncAwait
//
//  Created by Prashant Gaikwad on 16/07/21.
//

import Foundation

enum APIError: Error {
    case noData
    case apiFailed
    case parsingFailed
    case badUrl
}

class WebService {
    
    func fetchUsers(completionHandler: @escaping (Result< [User], APIError>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completionHandler(.failure(APIError.badUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(APIError.apiFailed))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(users))
                }
            }catch(let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            throw APIError.badUrl
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let users = try? JSONDecoder().decode([User].self, from: data)
        return users ?? []
    }
    
}
