//
//  CartCell.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 10/24/20.
//

import UIKit
import SDWebImage


protocol CartCellDelegate: AnyObject {
    func didTapButton(with title: String, cateid: String)
}

class CartCell: BaseTBCell {
    @IBOutlet weak var iconFood: UIImageView!
    @IBOutlet weak var nameFood: UILabel!
    @IBOutlet weak var priceFood: UILabel!
    @IBOutlet weak var countFood: UILabel!
    var cateid = ""

    var delegate: CartCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
   
    
    func setUpData(data: Cart )  {
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal
        iconFood.sd_setImage(with: URL(string: data.image ?? ""), completed: nil)
        nameFood.text = data.name
        cateid = data.id ?? ""
        priceFood.text = "Gia Tiền: " + "\(Defined.formatter.string(from: NSNumber(value: data.price ?? 0 ))!)"  + " VNĐ"
        countFood.text = "Số Lượng: " + String(data.count!)

    }
    
    
    @IBAction func btnTang(_ sender: Any) {
        delegate?.didTapButton(with: "1", cateid: cateid)
    }
    
    
}

