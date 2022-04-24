//
//  PostsResponse.swift
//
//  Created by Aldo Israel Navarro on 4/23/22
//  Copyright (c) . All rights reserved.
//

import Foundation

struct PostsResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case userId
    case body
    case id
    case title
  }

  var userId: Int?
  var body: String?
  var id: Int?
  var title: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    userId = try container.decodeIfPresent(Int.self, forKey: .userId)
    body = try container.decodeIfPresent(String.self, forKey: .body)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    title = try container.decodeIfPresent(String.self, forKey: .title)
  }

}
