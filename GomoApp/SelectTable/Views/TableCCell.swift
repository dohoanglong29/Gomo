//
//  TableCCell.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 11/3/20.
//

import UIKit
import Firebase

class TableCCell: BaseCLCell {
    
    @IBOutlet weak var statusTable: UIView!
    @IBOutlet weak var lblNumbleTable: UILabel!
    
    var idCart = 0
    var idTable = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusTable.layer.cornerRadius = 20
        statusTable.layer.borderWidth = 2
    }
    
   
    
    func setUp(data: Table){
        lblNumbleTable.text = String( data.NumberTable!)
    }
    
    func setupID(idCart: Int, idTable: Int) {
        self.idCart = idCart
        self.idTable = idCart
    }
    
}
