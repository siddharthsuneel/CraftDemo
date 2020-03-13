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
    private var viewModel = ViewModel()
    private var preference = Preferences() {
        didSet {
            print("New value for prefernces")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }
    
    private func setup() {
        setPreferences()
        viewModel.fetchData()
    }
    
    private func fetchData() {
        viewModel.observer = { [weak self] state in
            switch state {
            case .success:
                self?.refreshView()
                break
            case .showError(let errorMessage):
                //Show error: errorMessage
                print(errorMessage)
                break
            }
        }
    }
    
    private func setPreferences() {
        preference.data.centerText = "600"
        preference.data.startText = "s300"
        preference.data.endText = "e900"
        preference.data.score = 600
        
        headerCircularView.updatePreference(preference)
    }
    
    private func refreshView() {
        setPreferences()
        tblView.reloadData()
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
        if let rangeModel = viewModel.creditRangeFor(row: indexPath.row), let score = viewModel.getScore() {
            cell.setDataInCell(rangeModel: rangeModel, score: score)
        }
        return cell
    }
}
