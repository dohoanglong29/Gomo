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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpData(data:Bill){
        
        lblNumberTable.text = "Hoá đơn bàn: \(String(data.numberTable ?? ""))"
        lblAmount.text = String(data.Total ?? 0) + " VND"
        lblDate.text = String(data.time ?? "")
    }
    
    
    
}
