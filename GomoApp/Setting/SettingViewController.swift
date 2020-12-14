//
//  SettingViewController.swift
//  GomoApp
//
//  Created by Vương Toàn Bắc on 12/3/20.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let email = Defined.defaults.value(forKey: "email") as? String
    let avatar1 = Defined.defaults.value(forKey: "avatar") as? String
    
    var setiing = ["Thông tin cá nhân", "Hướng dẫn sử dụng", "Thêm bàn", "Đăng xuất"]
    var iconSetting = [ "profile","tutorial", "select_table", "logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingCell.registerCellByNib(tableView)
        setUp()
    }
    func setUp(){
        avatar.layer.cornerRadius = avatar.bounds.width/2
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        avatar.sd_setImage(with: URL(string: avatar1 ?? ""), completed: nil)
        lblName.text = email
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
            print("1")
        }
    }
    
    
    
}
