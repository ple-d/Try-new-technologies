//
//  PaginatedInfoCharactersResponse.swift
//  TryNewTechApp
//
//  Created by mac on 10.04.2023.
//

import ObjectMapper

struct PaginatedInfoCharactersResponse: ImmutableMappable {
    let count: Int
    let pages: Int
    let next: String?
    let previous: String?
    
    init(map: Map) throws {
        count = try map.value("count")
        pages = try map.value("pages")
        next = try map.value("next")
        previous = try map.value("previous")
    }
}
