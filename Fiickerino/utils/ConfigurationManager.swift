//
//  ConfigurationManager.swift
//  Flickerino
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import Foundation


class ConfigurationManager {

    enum Configuration: String {
        case debug = "Debug"
        case release = "Release"
        case production = "Production"
        case appstore = "AppStore"
    }

    // MARK: Shared instance
    static let shared = ConfigurationManager()

    // MARK: Properties
    private let configurationKey = "Configuration"
    private let configurationDictionaryName = "Configuration"
    private let apiURLKey = "apiURL"
    private let apiTokenKey = "apiToken"
    
    let activeConfiguration: Configuration
    private let activeConfigurationDictionary: NSDictionary

    // MARK: Lifecycle
    init () {
        let bundle = Bundle(for: ConfigurationManager.self)
        guard let rawConfiguration = bundle.object(forInfoDictionaryKey: configurationKey) as? String,
            let activeConfiguration = Configuration(rawValue: rawConfiguration),
            let configurationDictionaryPath = bundle.path(forResource: configurationDictionaryName, ofType: "plist"),
            let configurationDictionary = NSDictionary(contentsOfFile: configurationDictionaryPath),
            let activeEnvironmentDictionary = configurationDictionary[activeConfiguration.rawValue] as? NSDictionary
            else {
                fatalError("Configuration Error")

        }
        self.activeConfiguration = activeConfiguration
        self.activeConfigurationDictionary = activeEnvironmentDictionary
    }

    // MARK: Methods
    private func getActiveVariableValue<V>(forKey key: String) -> V {
        guard let value = activeConfigurationDictionary[key] as?  V else {
            fatalError("No value satysfying requirements")
        }
        return value
    }

    func isRunning(in configuration: Configuration) -> Bool {
        return activeConfiguration == configuration
    }
    
    var apiURL:String {
        get{
            let result:String = getActiveVariableValue(forKey: apiURLKey)
            return result
        }
    }
    
    var apiToken:String{
        get{
            let result:String = getActiveVariableValue(forKey: apiTokenKey)
            return result
        }
    }
    
   
    func isProduction() -> Bool{
        return activeConfiguration == .appstore
    }
}
