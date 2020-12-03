//
//  ProfileViewController.swift
//  GomoApp
//
//  Created by Vương Toàn Bắc on 12/3/20.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCmnd: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        btnSave.layer.cornerRadius = 10
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(singleTap)
    }
    
    @objc func tapDetected() {
        print("Imageview Clicked")
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        
    }
}
