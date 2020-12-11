//
//  DetailFoodCell.swift
//  GomoApp
//
//  Created by Vương Toàn Bắc on 12/12/20.
//

import UIKit

class DetailFoodCell: BaseTBCell {

    @IBOutlet weak var lblDetailfood: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(name: String){
        lblDetailfood.text = name
    }
    
}
