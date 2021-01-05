
import UIKit
import Firebase

class TableCCell: BaseCLCell {
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var statusTable: UIView!
    @IBOutlet weak var lblNumbleTable: UILabel!
    @IBOutlet weak var lblNameCreator: UILabel!
    
    var idCart = 0
    var idTable = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initComponent()
    }
    
     func initComponent() {
        statusTable.addShadow(radius: 1)
        statusTable.addBoder(radius: 20, color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
        subView.addShadow(radius: 1)
        subView.addBoder(radius: 20, color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
    }
    
    func setUp(data: Table){
        lblNumbleTable.text = String(data.NumberTable ?? 0)
        lblNameCreator.text = data.nameCreactor
    }
    
    func setupID(idCart: Int, idTable: Int ) {
        self.idCart = idCart
        self.idTable = idCart
        
    }
    
}
