//
//  NetworkProvidersFactory.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Alamofire
import Moya
import DeviceKit

class NetworkProvidersFactory {
    
    static let shared = NetworkProvidersFactory()
    
    private lazy var headersPlugin: PluginType = {
        let acceptLanguage = "ru"
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        let deviceUUid = Keychain[KeychainKeys.deviceUuid]
       return HeadersPlugin(userAgent: userAgent, acceptLanguage: acceptLanguage, deviceId: deviceId, deviceUuid: deviceUUid)
    }()
    
    private(set) lazy var userAgent: String = {
        let deviceModel = Device.current.description
        
        let osName = UIDevice.current.systemName
        
        let systemVersion = ProcessInfo.processInfo.operatingSystemVersion
        let osVersion = "\(systemVersion.majorVersion).\(systemVersion.minorVersion).\(systemVersion.patchVersion)"
        
        let appName = "TryNewTechApp"
        
        let buildVersion = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String
        let appVersion = buildVersion ?? "Unknown"
        
//         {deviceVendor}/{deviceModel} {OsName}/{OsVersion} {AppName}/{AppVersion}
        return "Apple/\(deviceModel) \(osName)/\(osVersion) \(appName)/\(appVersion)"
    }()
    
    private lazy var loggerPlugin = NetworkLoggerPlugin()
    
    // MARK: Providers
    
    private lazy var rickMainProvider: MoyaProvider<RickNetworkService> = {
        let interceptor = Interceptor(adapters: [], retriers: [])
        let session = Alamofire.Session(startRequestsImmediately: false)
        return MoyaProvider<RickNetworkService>(session: session, plugins: [loggerPlugin])
    }()
    
    // MARK: Methods
    
    func getRickProvider() -> MoyaProvider<RickNetworkService> {
        rickMainProvider
    }
    
}

extension NetworkProvidersFactory: DebugLoggable { }
