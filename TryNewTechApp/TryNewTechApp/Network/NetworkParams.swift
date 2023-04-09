//
//  NetworkParams.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Foundation

enum NetworkParams {
    #if DEBUG
    static let baseRickUrl = URL(string: "https://rickandmortyapi.com")!
    #else
    static let baseRickUrl = URL(string: "https://rickandmortyapi.com")!
    #endif
    
    static let apiRickUrl = baseRickUrl.appending(path: "api")
    
}
