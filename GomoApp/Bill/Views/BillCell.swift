import UIKit

class BillCell: BaseTBCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNumberTable: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var subView: UIView!
    var money = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initComponent()
    }
    
    func initComponent() {
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal
        subView.addBoder(radius: 20, color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
        subView.addShadow(radius: 5)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(data:Bill, s:String ){
        if s == "1" {
            lblDate.text = String(data.time ?? "")
            lblNumberTable.text = "Bàn số: \(String(data.numberTable ?? ""))"
            lblAmount.text = "\(Defined.formatter.string(from: NSNumber(value: data.totalPay ?? 0  ))!)" + " đ"
        }else{
            lblDate.text = String(data.time ?? "")
            lblNumberTable.text = "Bàn số: \(String(data.numberTable ?? ""))"
            lblAmount.text = "\(Defined.formatter.string(from: NSNumber(value: data.Total ?? 0  ))!)" + " đ"
        }
        
    }
}

