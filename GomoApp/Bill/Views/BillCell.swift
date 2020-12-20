import UIKit

class BillCell: BaseTBCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNumberTable: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    var money = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(data:Bill, s:String ){
        if s == "1" {
            lblDate.text = String(data.time ?? "")
            lblNumberTable.text = "Hoá đơn bàn: \(String(data.numberTable ?? ""))"
            lblAmount.text = "\(Defined.formatter.string(from: NSNumber(value: data.totalPay ?? 0  ))!)" + " VNĐ"
        }else{
            lblDate.text = String(data.time ?? "")
            lblNumberTable.text = "Hoá đơn bàn: \(String(data.numberTable ?? ""))"
            lblAmount.text = "\(Defined.formatter.string(from: NSNumber(value: data.Total ?? 0  ))!)" + " VNĐ"
        }
       
    }
}

