//
//  CharacterModel.swift
//  TryNewTechApp
//
//  Created by mac on 10.04.2023.
//

import ObjectMapper

struct CharacterModel: ImmutableMappable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: CharacterGenderEnum
    let origin: CharacterOrigin
    let location: CharacterLocation
    let imageAdress: String
    let episodes: [String]
    let url: String
    let created: String
    
    init(map: ObjectMapper.Map) throws {
        id = try map.value("id")
        name = try map.value("name")
        status = try map.value("status")
        species = try map.value("species")
        type = try map.value("type")
        gender = try map.value("gender")
        origin = try map.value("origin")
        location = try map.value("location")
        imageAdress = try map.value("image")
        episodes = try map.value("episode")
        url = try map.value("url")
        created = try map.value("created")
    }
}
