//
//  FoodCell.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 11/12/20.
//

import UIKit

class FoodCell: BaseCLCell {
    
    @IBOutlet weak var lblView: UIView!
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var nameFood: UILabel!
    @IBOutlet weak var bView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        customView()
    }
    
    func customView(){
        imageFood.layer.borderWidth = 0.1
        imageFood.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        imageFood.layer.cornerRadius = 20
        
        bView.layer.masksToBounds = false
        bView.layer.shadowColor = UIColor.black.cgColor
        bView.layer.shadowOpacity = 0.5
        bView.layer.shadowRadius = 1
        
        bView.layer.borderWidth = 0.1
        bView.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        bView.layer.cornerRadius = 20
        
        lblView.layer.borderWidth = 0.1
        lblView.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        lblView.layer.cornerRadius = 20
    }
    
    func setUpData(data:Menu){
        imageFood.sd_setImage(with: URL(string: data.image ?? ""), completed: nil)
        nameFood.text = data.name
    }
    

}
