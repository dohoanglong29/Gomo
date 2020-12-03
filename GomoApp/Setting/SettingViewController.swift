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
    
    var setiing = ["Thông tin cá nhân", "Thêm bàn", "Đăng xuất"]
    var iconSetting = [ "profile", "select_table", "logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingCell.registerCellByNib(tableView)
        
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
            print("1")
        case 1:
            print("2")
        default:
            print("3")
        }
    }
    
    
    
}
