//
//  ProfileViewController.swift
//  GomoApp
//
//  Created by Vương Toàn Bắc on 12/3/20.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblEmaill: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblAdd: UILabel!
    @IBOutlet weak var lblSex: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    let name = Defined.defaults.value(forKey: "name") as? String
    let avatar1 = Defined.defaults.value(forKey: "avatar") as? String
    let email = Defined.defaults.value(forKey: "email") as? String
    let add = Defined.defaults.value(forKey: "address") as? String
    let birtday = Defined.defaults.value(forKey: "birtday") as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
    func setUp(){
        avatar.layer.cornerRadius = avatar.bounds.width/2
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        subView.layer.shadowRadius = 7
        subView.layer.shadowOpacity = 0.3
        subView.layer.cornerRadius = 20
        
        avatar.sd_setImage(with: URL(string: avatar1 ?? ""), completed: nil)
        lblName.text = name
        lblAge.text = birtday
        lblAdd.text = add
        lblEmaill.text = email
    }
}
