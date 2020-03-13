//
//  Protocols.swift
//  CraftDemo-iOS
//
//  Created by Siddharth Suneel on 13/03/20.
//  Copyright © 2020 Siddharth Suneel. All rights reserved.
//

import Foundation

typealias CreditResponseCallback = (CreditModel?, Bool, Error?) -> ()

protocol ServiceCallable {
    func getData(completion: @escaping CreditResponseCallback)
}
