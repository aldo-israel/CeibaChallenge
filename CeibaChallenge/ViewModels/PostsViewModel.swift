//
//  PostsViewModel.swift
//  CeibaChallenge
//
//  Created by Aldo Israel Navarro on 4/23/22.
//

import Foundation

class PostsViewModel: ObservableObject {
    @Published var errorDescription = ""
    @Published var showErrorMessage = false
    @Published var posts: [PostsResponse] = []
    
    func getPosts() {
        NetworkManager().getPosts(completion: {
            result in
                                
            switch result {
            case .success(let posts):
                self.posts = posts
            case .failure(let error):
                self.errorDescription = error.localizedDescription
                self.showErrorMessage = true
            }
        })
    }
    
    func getPostsBy(userId: Int) {
        NetworkManager().getPostsBy(userId: userId, completion: {
            result in
                                
            switch result {
            case .success(let posts):
                self.posts = posts
            case .failure(let error):
                self.errorDescription = error.localizedDescription
                self.showErrorMessage = true
            }
        })
    }
}
