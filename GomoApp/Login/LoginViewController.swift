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
    @IBOutlet weak var btnHidePassword: UIButton!
    var checkEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getEmployeesData()
    }
    
    func setUpView() {
        ubView.layer.cornerRadius = 15
        btnLogin.layer.cornerRadius = 7
        txtPassword.isSecureTextEntry = true
    }
    
    @IBAction func btnHidePass(_ sender: Any) {
        if txtPassword.isSecureTextEntry == false{
            txtPassword.isSecureTextEntry = true
            let btnImage = UIImage(named: "eye_off")
            btnHidePassword.setImage(btnImage, for: .normal)
        }else{
            txtPassword.isSecureTextEntry = false
            let btnImage = UIImage(named: "eye_on")
            btnHidePassword.setImage(btnImage, for: .normal)
        }
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        if let email = txtUserName.text, let password = txtPassword.text{
            if  isValidEmail(email: email) == false && email.count != 0{
                self.showDialog(title: Constans.notification, message:Constans.alertEmail )
            }else{
                print(email)
            }
            
           
            Auth.auth().signIn(withEmail: email, password: password) {
                [weak self] user, error in
                if user != nil{
                   
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.tabbar) as! TabBarController
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                }else{
                    if email.isEmpty || password.isEmpty{
                        self?.showDialog(title: Constans.notification, message: Constans.isemptyLogin)
                    }else{
                        self?.showDialog(title: Constans.notification, message:Constans.checkEmail)
                        
                    }
                }
            }
        }
    }
    
    func getEmployeesData(){
        Defined.ref.child("Employees").observe(DataEventType.value) { (DataSnapshot) in
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshort {
                    let id = snap.key
                    if let value = snap.value as? [String: Any] {
                        let address = value["address"] as! String
                        let avatar = value["avatar"] as! String
                        let birthday = value["birthday"] as! String
                        let email = value["email"] as! String
                        let password = value["password"] as! String
                        let name = value["name"] as! String
                        let tempEmail = String(id) + "@gmail.com"
                        tempEmail == self.checkEmail
                       
                        
                        
                    }
                }
            }
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = Constans.validateEmail
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showDialog(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                        switch action.style{
                                        case .default: break
                                        case .cancel: break
                                        case .destructive: break
                                        }}))
        self.present(alert, animated: true, completion: nil)
    }
}
