//
//  UsersResponse.swift
//
//  Created by Aldo Israel Navarro on 4/23/22
//  Copyright (c) . All rights reserved.
//

import Foundation

struct UsersResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case address
    case company
    case id
    case username
    case phone
    case name
    case email
    case website
  }

  var address: UsersAddress?
  var company: UsersCompany?
  var id: Int?
  var username: String?
  var phone: String?
  var name: String?
  var email: String?
  var website: String?

    init() {
        
    }


  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    address = try container.decodeIfPresent(UsersAddress.self, forKey: .address)
    company = try container.decodeIfPresent(UsersCompany.self, forKey: .company)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    username = try container.decodeIfPresent(String.self, forKey: .username)
    phone = try container.decodeIfPresent(String.self, forKey: .phone)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    email = try container.decodeIfPresent(String.self, forKey: .email)
    website = try container.decodeIfPresent(String.self, forKey: .website)
  }

}
