//
//  CharacterLocation.swift
//  TryNewTechApp
//
//  Created by mac on 10.04.2023.
//

import ObjectMapper

struct CharacterLocation: ImmutableMappable {
    let name: String
    let url: String
    
    init(map: Map) throws {
        name = try map.value("name")
        url = try map.value("url")
    }
}
