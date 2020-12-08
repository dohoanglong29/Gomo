//
//  BillCell.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 11/12/20.
//

import UIKit

class BillCell: BaseTBCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNumberTable: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpData(data:Bill){
        
        lblNumberTable.text = "Hoá đơn bàn: \(String(data.numberTable ?? ""))"
        lblAmount.text = "\(Defined.formatter.string(from: NSNumber(value: data.Total ?? 0  ))!)" + " VNĐ"
        lblDate.text = String(data.time ?? "")
    }
    
    
    
}
