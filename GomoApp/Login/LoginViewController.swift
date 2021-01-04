

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
    var emailthis:String?
    var checkEmail = ""
    var birtday1 = ""
    var address1 = ""
    var avatar1 = ""
    var email1 = ""
    var name1 = ""
    
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
                        let user = Auth.auth().currentUser
                        if let u = user{
                            let email = u.email
                            self?.emailthis = email
                        }
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
                        if emailthis == email {
                            email1 = email ?? ""
                            Defined.defaults.set(email1, forKey: "email" )
                            address1 = address ?? ""
                            Defined.defaults.set(address1, forKey: "address" )
                            birtday1 = birtday ?? ""
                            Defined.defaults.set(birtday1, forKey: "birtday" )
                            name1 = name ?? ""
                            Defined.defaults.set(name1, forKey: "name" )
                            avatar1 = avatar ?? ""
                            Defined.defaults.set(avatar1, forKey: "avatar")

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
