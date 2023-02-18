//
//  Services.swift
//  VKServices
//
//  Created by Алёна Максимова on 17.02.2023.
//

import Foundation

struct Servises: Decodable {
    var items:[Service]
}

struct Service: Decodable {
    var name: String?
    var description: String?
    var icon_url: String?
    var service_url: String?
}
