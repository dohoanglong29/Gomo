//
//  AddTableViewController.swift
//  GomoApp
//
//  Created by BAC Vuong Toan (VTI.Intern) on 12/14/20.
//

import UIKit
import Firebase

class AddTableViewController: UIViewController {
    let name = Defined.defaults.value(forKey: "name") as? String
    var tables = [Table]()
    
    @IBOutlet weak var btnAddTable: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getNumberTable()
    }
    
    func getNumberTable(){
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table").observe(DataEventType.value) { (DataSnapshot) in
            self.tables.removeAll()
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshort {
                    _ = snap.key
                    if let value = snap.value as? [String: Any] {
                        let numberTable = value["NumberTable"] as! Int
                        let table = Table(NumberTable: numberTable)
                        self.tables.append(table)
                    }
                }
            }
        }
    }
    
    @IBAction func btnAddTable(_ sender: Any) {
        AlertUtil.actionAlert(from: self, with: Constans.notification, message: Constans.creactTable) { (ac) in
            let addTable = [
                "NumberTable": self.tables.count + 1,
                "statu": 1,
                "nameCreactor": self.name ?? "",] as [String: Any]
            Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table").child(String("\(self.tables.count + 1)")).setValue(addTable)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
