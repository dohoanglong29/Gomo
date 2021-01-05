

import UIKit

class FoodCell: BaseCLCell {
    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var nameFood: UILabel!
    @IBOutlet weak var bView: UIView!
    @IBOutlet weak var amountFood: UILabel!
    @IBOutlet weak var statusFood: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customView()
    }
    
    func customView(){
        imageFood.addBoder(radius: 20, color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
        bView.addShadow(radius: 5)
        bView.addBoder(radius: 20, color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
    }
    
    func setUpData(data:Menu){
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal
        imageFood.sd_setImage(with: URL(string: data.image ?? ""), completed: nil)
        nameFood.text = data.name
        amountFood.text = "\(Defined.formatter.string(from: NSNumber(value: data.price ?? 0 ))!)" + " đ"
        
        if data.statusFood == "0" {
            statusFood.text = "Hết hàng"
            statusFood.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }else{
            statusFood.text = "Còn hàng"
            statusFood.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
    }
}
