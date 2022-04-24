//
//  UsersCompany.swift
//
//  Created by Aldo Israel Navarro on 4/23/22
//  Copyright (c) . All rights reserved.
//

import Foundation

struct UsersCompany: Codable {

  enum CodingKeys: String, CodingKey {
    case bs
    case catchPhrase
    case name
  }

  var bs: String?
  var catchPhrase: String?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bs = try container.decodeIfPresent(String.self, forKey: .bs)
    catchPhrase = try container.decodeIfPresent(String.self, forKey: .catchPhrase)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
