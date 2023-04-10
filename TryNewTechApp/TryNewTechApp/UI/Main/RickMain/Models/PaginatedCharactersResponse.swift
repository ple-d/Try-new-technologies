//
//  PaginatedCharactersResponse.swift
//  TryNewTechApp
//
//  Created by mac on 10.04.2023.
//

import ObjectMapper

struct PaginatedCharactersResponse: ImmutableMappable {
    let info: PaginatedInfoCharactersResponse
    let results: [CharacterModel]
    
    init(map: Map) throws {
        info = try map.value("info")
        results = try map.value("results")
    }
}
