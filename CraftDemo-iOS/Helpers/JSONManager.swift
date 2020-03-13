//
//  JSONManager.swift
//  CraftDemo-iOS
//
//  Created by Siddharth Suneel on 11/03/20.
//  Copyright © 2020 Siddharth Suneel. All rights reserved.
//

import Foundation

final class JSONManager {
    
    class func readJSONData(fromFile fileName: String) -> Data? {
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        do {
            if let _url = url {
                let data = try Data(contentsOf: _url)
                return data
            }else {
                return nil
            }
        } catch let error {
            debugPrint(error)
            return nil
        }
    }
}
