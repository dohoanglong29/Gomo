

import UIKit

class SettingCell: BaseTBCell {

    @IBOutlet weak var iconSetting: UIImageView!
    @IBOutlet weak var lblSetting: UILabel!
    @IBOutlet weak var subView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subView.addShadow(radius: 10)
        subView.addBoder(radius: 10, color: #colorLiteral(red: 0.1170637682, green: 0.6766145825, blue: 0.9572572112, alpha: 1))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpData(icon: String , name: String) {
        iconSetting.image = UIImage(named: icon)
        lblSetting.text = name
    }
    
}
