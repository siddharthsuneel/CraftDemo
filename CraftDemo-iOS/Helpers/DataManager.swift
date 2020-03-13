//
//  DataManager.swift
//  CraftDemo-iOS
//
//  Created by Siddharth Suneel on 13/03/20.
//  Copyright © 2020 Siddharth Suneel. All rights reserved.
//

import Foundation

class DataManager: ServiceCallable {
    func getData(completion: @escaping CreditResponseCallback) {
        if let data = JSONManager.readJSONData(fromFile: "response") {
            do {
                let model = try JSONDecoder().decode(CreditModel.self, from: data)
                print(model)
                completion(model, true, nil)
            } catch let error {
                print(error)
                completion(nil, false, error)
            }
        }
    }
}
