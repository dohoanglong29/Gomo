

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var ubView: UIView!
    @IBOutlet weak var btnForgetPassword: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnHidePassword: UIButton!
    
    var employees = [Employees]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
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
                AlertUtil.showAlert(from: self, with:Constans.notification, message: Constans.alertEmail)
            }else{
                Auth.auth().signIn(withEmail: email, password: password) {
                    [weak self] authResult, error in
                    if authResult != nil{
                        self?.getDataEmployees()
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.tabbar) as! TabBarController
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true, completion: nil)
                    }else{
                        if email.isEmpty || password.isEmpty{
                            AlertUtil.showAlert(from: self!, with:Constans.notification, message: Constans.isemptyLogin)
                        }else{
                            AlertUtil.showAlert(from: self!, with:Constans.notification, message: Constans.checkEmail)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func btnResetPassword(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.resetPass) as! ResetPasswordViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func getDataEmployees(){
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Employees").observe(DataEventType.value) { [self] (DataSnapshot) in
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                self.employees.removeAll()
                for snap in snapshort {
                    _ = snap.key
                    if let value = snap.value as? [String: Any] {
                        let address = value["address"] as? String
                        let avatar = value["avatar"] as? String
                        let birtday = value["birthday"] as? String
                        let email = value["email"] as? String
                        let name = value["name"] as? String
                        if txtUserName.text == email {
                            Defined.defaults.set(email, forKey: "email" )
                            Defined.defaults.set(address, forKey: "address" )
                            Defined.defaults.set(birtday, forKey: "birtday" )
                            Defined.defaults.set(name, forKey: "name" )
                            Defined.defaults.set(avatar, forKey: "avatar")
                        }
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
}
