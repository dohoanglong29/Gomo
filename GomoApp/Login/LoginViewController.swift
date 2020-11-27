//
//  LoginViewController.swift
//  GomoApp
//
//  Created by BAC Vuong Toan (VTI.Intern) on 11/27/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnForgetPassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.tabbar) as! TabBarController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
}
