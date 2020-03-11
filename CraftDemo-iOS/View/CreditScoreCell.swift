//
//  CreditScoreCell.swift
//  CraftDemo-iOS
//
//  Created by Siddharth Suneel on 11/03/20.
//  Copyright © 2020 Siddharth Suneel. All rights reserved.
//

import UIKit

class CreditScoreCell: UITableViewCell {

    @IBOutlet weak var percentageLbl: UILabel!
    @IBOutlet weak var colorStripView: UIView!
    @IBOutlet weak var rangeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataInCell(rangeModel: CreditRangeModel, score: Int) {
        percentageLbl.text = rangeModel.percentage
        rangeLbl.text = rangeModel.getRangeText()
        colorStripView.backgroundColor = rangeModel.getColor()
        
        drawArrowShapeIfNeeded(rangeModel: rangeModel, score: score)
    }
    
    func drawArrowShapeIfNeeded(rangeModel: CreditRangeModel, score: Int) {
        if let start = rangeModel.startRange,
            let end = rangeModel.endRange, score > start  && score < end {
            //draw shape layer
        }
    }
}
