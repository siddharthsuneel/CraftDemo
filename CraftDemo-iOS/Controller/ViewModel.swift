//
//  ViewModel.swift
//  CraftDemo-iOS
//
//  Created by Siddharth Suneel on 13/03/20.
//  Copyright © 2020 Siddharth Suneel. All rights reserved.
//

import Foundation

class ViewModel {
    
    //Vairables
    private let serviceHandler: ServiceCallable
    private var model: CreditModel?
    
    //Closures
    var observer: (_ refreshState: ViewModelObservationState) -> Void = {_ in }
    
    //Initialiser
    init(service: ServiceCallable = DataManager()) {
        serviceHandler = service
    }
    
    //MARK: Public Methods
    func fetchData() {
        serviceHandler.getData { [weak self] (model, success, error) in
            guard let `self` = self else { return }
            guard success else {
                self.observer(.showError(message: "Failed to fetch data from server."))
                return
            }
            
            guard let modelData = model else {
                self.observer(.showError(message: "Error while fetching data"))
                return
            }
            self.model = modelData
            self.observer(.success)
        }
    }
    
    func getScore() -> Double? {
        return model?.score
    }
    
    func creditRangeFor(row: Int) -> CreditRangeModel? {
        if let ranges = model?.ranges, row < ranges.count {
            return ranges[row]
        }
        return nil
    }
}
