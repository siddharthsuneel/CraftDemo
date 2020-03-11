//
//  SSCircularView.swift
//  CraftDemo-iOS
//
//  Created by Siddharth Suneel on 11/03/20.
//  Copyright © 2020 Siddharth Suneel. All rights reserved.
//

import UIKit

class SSCircularView: UIView {
    
    @IBOutlet weak var centerLbl: UILabel!
    
    private var globalPreferences: Preferences = Preferences() {
        didSet {
            //Redraw
        }
    }
    let shapeLayer = CAShapeLayer()
    
    var startLbl = UILabel(frame: .zero)
    var endLbl = UILabel(frame: .zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setFont()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setFont()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("LayoutSubviews: ", self.frame)
        setLabelsFrame(frame: self.bounds)
    }
    
    convenience init(frame: CGRect, preference: Preferences) {
        self.init(frame: frame)
        self.globalPreferences = preference
    }
    
    func setFont() {
        startLbl.font = UIFont.systemFont(ofSize: 12.0)
        endLbl.font = UIFont.systemFont(ofSize: 12.0)
    }
    
    func updatePreference(_ preference: Preferences) {
        globalPreferences = preference
        setup()
        setupUI()
        layoutIfNeeded()
    }
    
    private func setupUI() {
        startLbl.text = globalPreferences.data.startText
        endLbl.text = globalPreferences.data.endText
        centerLbl.text = globalPreferences.data.centerText
        
        self.addSubview(startLbl)
        self.addSubview(endLbl)
    }
    
    private func setLabelsFrame(frame: CGRect, position: ArcPosition = .bottom) {
        print("setLabelsFrame called for position:", position)
        let w: CGFloat = 50.0
        let h: CGFloat = 30.0
        
        switch position {
        case .bottom:
            
            startLbl.frame = CGRect.init(x: frame.maxX / 2, y: frame.maxY, width: w, height: h)
            endLbl.frame = CGRect.init(x: frame.maxX, y: frame.maxY / 2, width: w, height: h)
            
            startLbl.isHidden = false
            endLbl.isHidden = false
            
            print("Frame of Circular View:", self.frame)
            print("label frame set: ", startLbl.frame, endLbl.frame)
        default:
            break
        }
        layoutIfNeeded()
    }
    
    private func setup() {
        globalPreferences.drawing.center = CGPoint(x: (self.center.x - frame.minX), y: (self.center.y - frame.minY))
        
        let radius = (self.bounds.width - 20) / 2
        
        if globalPreferences.drawing.showTrack {
            
            let trackLayer = CAShapeLayer()
            let trackPath = UIBezierPath(arcCenter: globalPreferences.drawing.center, radius: radius, startAngle: globalPreferences.positioning.startAngle(), endAngle: globalPreferences.positioning.fullCircleAngle, clockwise: globalPreferences.drawing.clockwise)
            
            trackLayer.path = trackPath.cgPath
            trackLayer.strokeColor = globalPreferences.drawing.trackStrokeColor.cgColor
            trackLayer.lineWidth = globalPreferences.drawing.lineWidth
            trackLayer.lineCap = globalPreferences.drawing.lineCap
            
            trackLayer.fillColor = UIColor.clear.cgColor
            layer.addSublayer(trackLayer)
        }
        
        
        let circularPath = UIBezierPath(arcCenter: globalPreferences.drawing.center, radius: radius, startAngle: globalPreferences.positioning.startAngle(), endAngle: globalPreferences.positioning.endAngle(CGFloat(globalPreferences.data.score)), clockwise: globalPreferences.drawing.clockwise)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = globalPreferences.drawing.foregroundStrokeColor.cgColor
        shapeLayer.lineWidth = globalPreferences.drawing.lineWidth
        shapeLayer.lineCap = globalPreferences.drawing.lineCap
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(shapeLayer)
        
        doAnimate()
    }
    
    func doAnimate() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 2.0
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = .forwards
        basicAnimation.delegate = self
        
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
//    private func getBeizerPath() -> UIBezierPath {
//        let path = UIBezierPath(arcCenter: globalPreferences.drawing.center, radius: 100.0, startAngle: globalPreferences.positioning.startAngle(), endAngle: globalPreferences.positioning.endAngle(600), clockwise: globalPreferences.drawing.clockwise)
//
//        return path
//    }
}

extension SSCircularView: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print("animationDidStart")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animationDidStop, flag:", flag)
    }
}
