

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSent: UIButton!
    let auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSent(_ sender: Any) {
        if let email = txtEmail.text {
            if  isValidEmail(email: email) == false && email.count != 0{
                AlertUtil.showAlert(from: self, with:Constans.notification, message: Constans.alertEmail)
            }else{
                auth.sendPasswordReset(withEmail: txtEmail.text!) { (error) in
                    if error != nil {
                        return
                    }
                    AlertUtil.showAlert(from: self, with: Constans.notification, message: Constans.letterBox)
                    self.dismiss(animated: true, completion: nil)
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
