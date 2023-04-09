//
//  HeadersPlugin.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Moya

class HeadersPlugin: PluginType {
    private let contentTypeKey = "Content-Type"
    private let userAgentKey = "User-Agent"
    private let acceptLanguageKey = "Accept-Language"
    private let deviceIdKey = "device-id"
    private let deviceUuidKey = "device-uuid"
    
    
    let userAgent: String
    let acceptLanguage: String
    let deviceId: String?
    let deviceUuid: String?
    
    init(userAgent: String, acceptLanguage: String, deviceId: String?, deviceUuid: String?) {
        self.userAgent = userAgent
        self.deviceId = deviceId
        self.deviceUuid = deviceUuid
        self.acceptLanguage = acceptLanguage
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        request.addValue("application/json", forHTTPHeaderField: contentTypeKey)
        
        request.addValue(userAgent, forHTTPHeaderField: userAgentKey)
        request.addValue(acceptLanguage, forHTTPHeaderField: acceptLanguageKey)
        if let deviceId = deviceId {
            request.addValue(deviceId, forHTTPHeaderField: deviceIdKey)
        }
        if let deviceUuid = deviceUuid {
            request.addValue(deviceUuid, forHTTPHeaderField: deviceUuidKey)
        }
        
        return request
    }
}
