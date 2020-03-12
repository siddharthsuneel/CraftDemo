//
//  ViewController.swift
//  CraftDemo-iOS
//
//  Created by Siddharth Suneel on 11/03/20.
//  Copyright © 2020 Siddharth Suneel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //IBOulets
    @IBOutlet weak var headerCircularView: SSCircularView!    
    @IBOutlet weak var tblView: UITableView! {
        didSet {
            tblView.tableFooterView = UIView()
            tblView.separatorStyle = .none
        }
    }
    
    //Variables
    private var preference = Preferences() {
        didSet {
            print("New value for prefernces")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DataManager().getData { (model, success, error) in
            
        }
        
        setup()
    }
    
    private func setup() {
        preference.data.centerText = "600"
        preference.data.startText = "s300"
        preference.data.endText = "e900"
        preference.data.score = 600
        
        preference.drawing.lineCap = .square
        preference.drawing.lineWidth = 10.0
        
        headerCircularView.updatePreference(preference)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditScoreCell") as! CreditScoreCell
        cell.setDataInCell(rangeModel: CreditRangeModel(), score: 820)
        return cell
    }
}

class ViewModel {
    
    //Vairables
    private let serviceHandler = DataManager()
    private var model: CreditModel?
    
    //Closures
    var observer: (_ refreshState: ViewModelObservationState) -> Void = {_ in }
    
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
}

class DataManager {
    func getData(completion: @escaping (CreditModel?, Bool, Error?) -> ()) {
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
