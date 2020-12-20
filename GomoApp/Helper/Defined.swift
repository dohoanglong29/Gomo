

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
            let doneAction = UIAlertAction(title: "Tôi hiểu!", style: .cancel, handler: nil)
            alert.addAction(doneAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    class func actionAlert(from viewController: UIViewController, with title: String, message: String,  completion : (@escaping (UIAlertAction) -> Void)) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let doneAction = UIAlertAction(title: "Đồng ý ", style: .default, handler: completion)
            alert.addAction(doneAction)
            let cancelAction = UIAlertAction(title: "Đóng", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }

}


