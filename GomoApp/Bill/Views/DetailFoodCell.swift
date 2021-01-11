
import UIKit

class DetailFoodCell: BaseTBCell {

    @IBOutlet weak var lblDetailPrice: UILabel!
    @IBOutlet weak var lblDetailfood: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(name: String, price: Int, note:String){
        lblDetailfood.text = name
        lblDetailPrice.text = "= " + String(price)
        lblNote.text = "Ghi chú: " + note ?? ""
    }
    
}
