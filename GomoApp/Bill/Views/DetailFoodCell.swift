
import UIKit

class DetailFoodCell: BaseTBCell {

    @IBOutlet weak var lblDetailPrice: UILabel!
    @IBOutlet weak var lblDetailfood: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(name: String, price: Int){
        lblDetailfood.text = name
        lblDetailPrice.text = "= " + String(price)
    }
    
}
