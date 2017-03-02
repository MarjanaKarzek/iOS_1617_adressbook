//
//  CustomView.swift
//  Ue6-Karzek
//
//  Created by Marjana Karzek on 18/01/17.
//  Copyright © 2017 Marjana Karzek. All rights reserved.
//

import UIKit

class CustomView: UIView {
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        /*guard let gc = UIGraphicsGetCurrentContext() else {
            return
        }*/
        
        
        let center = self.center
        
        // Drawing code
        let colorRect = UIColor.brown
        let pathRect = UIBezierPath(rect: CGRect(x: CGFloat(center.x-50), y: CGFloat(center.y-60), width: CGFloat(100), height: CGFloat(100)))
        colorRect.setFill()
        pathRect.fill()
        
        let colorTriangle = UIColor.red
        let pathTriangle = UIBezierPath()
        let y0 = CGFloat(center.x+50)
        let x0 = CGFloat(center.x)
        let d = CGFloat(50)
        pathTriangle.move(to: CGPoint(x: x0, y: y0-10))
        pathTriangle.addLine(to: CGPoint(x: x0+d, y: y0+d))
        pathTriangle.addLine(to: CGPoint(x: x0-d, y: y0+d))
        pathTriangle.close()
        colorTriangle.setFill()
        pathTriangle.fill()
    }
}
