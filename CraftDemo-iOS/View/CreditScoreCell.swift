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
    @IBOutlet weak var arrowView: UIView!
    @IBOutlet weak var scoreLbl: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func prepareForReuse() {
        arrowView.isHidden = true
        scoreLbl.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataInCell(rangeModel: CreditRangeModel, score: Double) {
        if let percentage = rangeModel.percentage {
            percentageLbl.text = percentage + "%"
        }
        rangeLbl.text = rangeModel.getRangeText()
        colorStripView.backgroundColor = rangeModel.getColor()
        
        drawArrowShapeIfNeeded(rangeModel: rangeModel, score: score)
    }
    
    func drawArrowShapeIfNeeded(rangeModel: CreditRangeModel, score: Double) {
        if let start = rangeModel.startRange,
            let end = rangeModel.endRange, Int(score) > start && Int(score) < end {
            //draw shape layer
            arrowView.isHidden = false
            scoreLbl.text = "\(Int(score))"
            
            //Check if arrow tip is already there.
            arrowView.layer.sublayers?.forEach({ layer in
                if layer.name == "ArrowTip" {
                    arrowView.removeFromSuperview()
                }
            })
            
            let height = frame.size.height
            let width = frame.size.width
            let tipSize: CGFloat = 30.0
            let path = CGMutablePath()

            path.move(to: CGPoint(x: tipSize, y: 0))
            path.addLine(to: CGPoint(x: 0, y: height/2))
            path.addLine(to: CGPoint(x: tipSize, y: height))
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: width, y: 0))
            path.addLine(to: CGPoint(x: tipSize, y:0))
            
            let shape = CAShapeLayer()
            shape.path = path
            shape.name = "ArrowTip"
            shape.fillColor = UIColor.white.cgColor
            arrowView.layer.insertSublayer(shape, at: 0)
            
            let shadowPath = CGMutablePath()

            shadowPath.move(to: CGPoint(x: tipSize + 15, y: 15))
            shadowPath.addLine(to: CGPoint(x: tipSize + 15, y: height + 15))
            shadowPath.addLine(to: CGPoint(x: width + 15, y: height + 15))
            shadowPath.addLine(to: CGPoint(x: width + 15, y: 15))
            shadowPath.addLine(to: CGPoint(x: tipSize + 15, y: 15))

            let shadowShape = CAShapeLayer()
            shadowShape.path = shadowPath
            shadowShape.fillColor = UIColor.gray.withAlphaComponent(0.3).cgColor
            arrowView.layer.insertSublayer(shadowShape, at: 0)
        }
    }
}
