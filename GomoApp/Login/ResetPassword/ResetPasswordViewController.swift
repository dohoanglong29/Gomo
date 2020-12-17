//
//  ResetPasswordViewController.swift
//  GomoApp
//
//  Created by BAC Vuong Toan (VTI.Intern) on 12/17/20.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSent: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSent(_ sender: Any) {
        if let email = txtEmail.text {
            if  isValidEmail(email: email) == false && email.count != 0{
                AlertUtil.showAlert(from: self, with:Constans.notification, message: Constans.alertEmail)
            }else{
                print(email)
            }
            
            let auth = Auth.auth()
            
            auth.sendPasswordReset(withEmail: txtEmail.text!) { (error) in
                if let error = error {
                    return
                }
                AlertUtil.showAlert(from: self, with: Constans.note, message: "Vui lòng kiểm tra email của bạn!")
            }
        }
        
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = Constans.validateEmail
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
