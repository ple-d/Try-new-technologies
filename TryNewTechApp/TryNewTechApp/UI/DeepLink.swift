//
//  DeepLink.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

enum DeepLink {
    
}

extension DeepLink: DeepLinkable {
    func getCoordType() -> DeepLinkStartable.Type {
        return MainCoordinator.self
    }
}
