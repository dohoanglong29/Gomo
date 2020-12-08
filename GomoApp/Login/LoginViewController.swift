//
//  LoginViewController.swift
//  GomoApp
//
//  Created by BAC Vuong Toan (VTI.Intern) on 11/27/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var ubView: UIView!
    @IBOutlet weak var btnForgetPassword: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        ubView.layer.cornerRadius = 15
        btnLogin.layer.cornerRadius = 7
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        if let email = txtUserName.text, let password = txtPassword.text{
            Auth.auth().signIn(withEmail: email, password: password) {
                [weak self] authResult, error in
                
                if let user = authResult{
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.tabbar) as! TabBarController
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                    
                }else{
                    print("test")
                }
                
                
            }
        }
    }
}
