//
//  RickNetworkService.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Moya

enum RickNetworkService {
    case character(page: Int)
}

extension RickNetworkService: TargetType {
    
    var baseURL: URL {
        return NetworkParams.apiRickUrl
    }
    
    var path: String {
        switch self {
        case .character(page: let page):
            return "/character/?page=\(page)"
        }
    }
    
    var method: Method {
        switch self {
        case .character:
            return .get
        }
    }
    
    var task: Task {
        let encoding: ParameterEncoding
        switch self.method {
        case .post:
            encoding = JSONEncoding.default
        default:
            encoding = URLEncoding.default
        }
        
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: encoding)
        }
        
        return .requestPlain
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .character:
            return nil
        }
    }
    
    var headers: [String: String]? {
        ["signature": "0"]
    }
    
    var validationType: ValidationType {
        .successAndRedirectCodes
    }
}
