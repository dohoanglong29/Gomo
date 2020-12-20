

import UIKit

class SettingCell: BaseTBCell {

    @IBOutlet weak var iconSetting: UIImageView!
    @IBOutlet weak var lblSetting: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpData(icon: String , name: String) {
        iconSetting.image = UIImage(named: icon)
        lblSetting.text = name
    }
    
}
