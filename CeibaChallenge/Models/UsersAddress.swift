//
//  UsersAddress.swift
//
//  Created by Aldo Israel Navarro on 4/23/22
//  Copyright (c) . All rights reserved.
//

import Foundation

struct UsersAddress: Codable {

  enum CodingKeys: String, CodingKey {
    case city
    case zipcode
    case geo
    case street
    case suite
  }

  var city: String?
  var zipcode: String?
  var geo: UsersGeo?
  var street: String?
  var suite: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    city = try container.decodeIfPresent(String.self, forKey: .city)
    zipcode = try container.decodeIfPresent(String.self, forKey: .zipcode)
    geo = try container.decodeIfPresent(UsersGeo.self, forKey: .geo)
    street = try container.decodeIfPresent(String.self, forKey: .street)
    suite = try container.decodeIfPresent(String.self, forKey: .suite)
  }

}
