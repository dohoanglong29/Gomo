

import UIKit
import SDWebImage

class CartCell: BaseTBCell {
    @IBOutlet weak var iconFood: UIImageView!
    @IBOutlet weak var nameFood: UILabel!
    @IBOutlet weak var priceFood: UILabel!
    @IBOutlet weak var countFood: UILabel!
    var cateid = ""

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
        priceFood.text = "Gia Tiền: " + "\(Defined.formatter.string(from: NSNumber(value: data.price ?? 0 ))!)"  + " đ"
        countFood.text = "Số Lượng: " + String(data.count!)
    }
}

