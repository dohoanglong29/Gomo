//
//  CartCell.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 10/24/20.
//

import UIKit
import SDWebImage

class CartCell: BaseTBCell {

    @IBOutlet weak var iconFood: UIImageView!
    @IBOutlet weak var nameFood: UILabel!
    @IBOutlet weak var priceFood: UILabel!
    @IBOutlet weak var countFood: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btnStepper(_ sender: Any) {
       // countFood.text = String(sender.value)
    }
    
    
    
    func setUpData(data: Cart)  {
        iconFood.sd_setImage(with: URL(string: data.image ?? ""), completed: nil)
        nameFood.text = data.name
        priceFood.text = "Gia Tiền: " + String(data.price!) + "đ"
        countFood.text = "Số Lượng: " + String(data.count!)

    }
    
}

