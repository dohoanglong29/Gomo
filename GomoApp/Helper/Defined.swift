//
//  Defined.swift
//  GomoApp
//
//  Created by Vương Toàn Bắc on 11/23/20.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


class Defined {
    static let defaults = UserDefaults.standard
    static let storage = Storage.storage().reference()
    static let ref = Database.database().reference()
    static let formatter = NumberFormatter()
    
}

class AlertUtil {
    class func showAlert(from viewController: UIViewController, with title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let doneAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(doneAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}


