//
//  Status.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/13/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import Foundation

struct Status: Decodable {
    let Allowed: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        Allowed = try response.decode(Bool.self, forKey: .Allowed)
    }
    
    enum CodingKeys: String, CodingKey {
        case Allowed = "allowed"
        case data = "data"
    }
}
