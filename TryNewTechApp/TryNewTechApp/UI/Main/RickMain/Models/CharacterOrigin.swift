//
//  CharacterOrigin.swift
//  TryNewTechApp
//
//  Created by mac on 10.04.2023.
//

import ObjectMapper

struct CharacterOrigin: ImmutableMappable {
    let name: String
    let url: String
    
    init(map: ObjectMapper.Map) throws {
        name = try map.value("name")
        url = try map.value("url")
    }
}
