//
//  Constants.swift
//  ComprasUSA
//
//  Created by Maria Eugênia Pereira Teixeira on 22/03/20.
//  Copyright © 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import Foundation


struct Constants {
    
    struct SettingsBundleKeys {
        static let Dollar_Currency = "DOLLAR_CURRENCY"
        static let IOF = "IOF"
    }
    
    struct Settings {

        static var dollarCurrency: String {
            get {
                guard let dollarCurrency = UserDefaults.standard.string(forKey: SettingsBundleKeys.Dollar_Currency) else  {
                    UserDefaults.standard.set("5.6", forKey: SettingsBundleKeys.Dollar_Currency)
                    return "5.6"
                }
                return dollarCurrency
            }
        }
        
        static var iof: String {
            get {
                guard let iof = UserDefaults.standard.string(forKey: SettingsBundleKeys.IOF) else  {
                    UserDefaults.standard.set("6.38", forKey: SettingsBundleKeys.IOF)
                    return "6.38"
                }
                return iof
            }
        }
        
        static func updateDollarCurrency(with currency: String) {
            UserDefaults.standard.set(currency, forKey: SettingsBundleKeys.Dollar_Currency)
        }
        
        static func updateIOF(with currency: String) {
            UserDefaults.standard.set(currency, forKey: SettingsBundleKeys.IOF)
        }
    }
}
