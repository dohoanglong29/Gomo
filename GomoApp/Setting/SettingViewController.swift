
import UIKit
import SDWebImage

class SettingViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let name = Defined.defaults.value(forKey: "name") as? String
    let avatar1 = Defined.defaults.value(forKey: "avatar") as? String
    
    var setiing = ["Thông tin cá nhân", "Hướng dẫn sử dụng", "Thêm bàn", "Đăng xuất"]
    var iconSetting = [ "profile","tutorial", "select_table", "logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingCell.registerCellByNib(tableView)
        setUp()
    }
     
    func setUp(){
        print(avatar1 ?? "")
        avatar.layer.cornerRadius = avatar.bounds.width/2
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        avatar.sd_setImage(with: URL(string: avatar1 ?? ""), completed: nil)
        lblName.text = name
        tableView.layer.cornerRadius = 20
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.6
        tableView.layer.shadowOffset = .zero
        tableView.layer.shadowRadius = 10
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setiing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingCell.loadCell(tableView) as!  SettingCell
        cell.setUpData(icon: iconSetting[indexPath.row], name: setiing[indexPath.row])
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
