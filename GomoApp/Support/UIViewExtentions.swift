//
//  UIViewExtentions.swift
//  GomoApp
//
//  Created by BAC Vuong Toan (VTI.Intern) on 1/5/21.
//

import UIKit

extension UIView {
    func addShadow(radius: CGFloat) {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
    }
    
    func addBoder(radius: CGFloat , color: CGColor) {
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = radius
        self.layer.borderColor  = color
    }
}
