//
//  UsersViewModel.swift
//  CeibaChallenge
//
//  Created by Aldo Israel Navarro on 4/23/22.
//

import Foundation
import SwiftUI
import CoreData

class UsersViewModel: ObservableObject {
    @Published var errorDescription = ""
    @Published var showErrorMessage = false
    @Published var users: [UsersResponse] = []
    @Published var filteredUsers: [UsersResponse] = []
    
    func getUsers() {
        NetworkManager().getUsers(completion: {
            result in
                                
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                self.errorDescription = error.localizedDescription
                self.showErrorMessage = true
            }
        })
    }
    
    func filterUsers(searchText: String) {
        if !users.isEmpty {
            filteredUsers = users.filter { user in
                if let name = user.name {
                    return name.contains(searchText)
                } else {
                    return false
                }
            }
        }
    }
    
    func fillUsers(savedUsers: FetchedResults<User>) {
        for savedUser in savedUsers {
            var user = UsersResponse()
            user.id = Int(savedUser.id)
            user.username = savedUser.username
            user.name = savedUser.name
            user.website = savedUser.website
            user.email = savedUser.email
            user.phone = savedUser.phone
            users.append(user)
        }
    }
}
