
import UIKit
import SDWebImage

class SettingViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tableView: UITableView!
        
    var setiing = ["Thông tin cá nhân", "Hướng dẫn sử dụng", "Thêm bàn", "Đăng xuất"]
    var iconSetting = [ "profile","tutorial","select_table","logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
     
    func setUp(){
        avatar.addShadow(radius: 10)
        avatar.addBoder(radius: avatar.bounds.width/2, color: #colorLiteral(red: 0.1170637682, green: 0.6766145825, blue: 0.9572572112, alpha: 1))
        SettingCell.registerCellByNib(tableView)
        avatar.sd_setImage(with: URL(string: Defined.defaults.value(forKey: "avatar") as! String ), completed: nil)
        lblName.text = Defined.defaults.value(forKey: "name") as? String
    
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setiing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingCell.loadCell(tableView) as!  SettingCell
        cell.setUpData(icon: iconSetting[indexPath.row], name: setiing[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.profile) as! ProfileViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.tutorial) as! TutorialViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.addTable) as! AddTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            Defined.defaults.removeObject(forKey: "email")
            Defined.defaults.removeObject(forKey: "avatar")
            Defined.defaults.removeObject(forKey: "name")
            Defined.defaults.removeObject(forKey: "avatar")
            Defined.defaults.removeObject(forKey: "birtday")
            Defined.defaults.removeObject(forKey: "address")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
