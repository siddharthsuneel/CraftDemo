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
    private var preference = Preferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }
    
    private func setup() {
        setPreferences()
        addDataObserver()
        viewModel.fetchData()
    }
    
    private func addDataObserver() {
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
        if let score = viewModel.getScore() {
            preference.data.centerText = "\(Int(score))"
            preference.data.score = score
        }
        preference.data.startText = "300"
        preference.data.endText = "900"
        
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
