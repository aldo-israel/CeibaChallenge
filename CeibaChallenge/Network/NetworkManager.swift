//
//  NetworkManager.swift
//  CeibaChallenge
//
//  Created by Aldo Israel Navarro on 4/23/22.
//

import Foundation
import Alamofire

class NetworkManager {
    let BASE_URL = "https://jsonplaceholder.typicode.com"
    
    private let manager: Session
    
    init(manager: Session = Session.default) {
        self.manager = manager
    }
    
    func getUsers(completion: @escaping (AFResult<[UsersResponse]>) -> Void) {
        
        let url = "\(BASE_URL)/users"
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default)
        .responseDecodable {
            (response: AFDataResponse<[UsersResponse]>) in
            completion(response.result)
        }
    }
    
    func getPosts(completion: @escaping (AFResult<[PostsResponse]>) -> Void) {
        
        let url = "\(BASE_URL)/posts"
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default)
        .responseDecodable {
            (response: AFDataResponse<[PostsResponse]>) in
            completion(response.result)
        }
    }
    
    func getPostsBy(userId: Int,
                           completion: @escaping (AFResult<[PostsResponse]>) -> Void) {
        
        let url = "\(BASE_URL)/posts?userId=\(userId)"
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default)
        .responseDecodable {
            (response: AFDataResponse<[PostsResponse]>) in
            completion(response.result)
        }
    }
}
