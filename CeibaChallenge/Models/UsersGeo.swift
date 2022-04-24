//
//  UsersGeo.swift
//
//  Created by Aldo Israel Navarro on 4/23/22
//  Copyright (c) . All rights reserved.
//

import Foundation

struct UsersGeo: Codable {

  enum CodingKeys: String, CodingKey {
    case lat
    case lng
  }

  var lat: String?
  var lng: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    lat = try container.decodeIfPresent(String.self, forKey: .lat)
    lng = try container.decodeIfPresent(String.self, forKey: .lng)
  }

}
