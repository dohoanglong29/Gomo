//
//  BillViewController.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 11/12/20.
//

import UIKit
import Firebase

class BillViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmented: UISegmentedControl!
    var bills = [Bill]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BillCell.registerCellByNib(tableView)
        getDataBill()
        
    }
    
    
    func getDataBill(){
            Defined.ref.child("Bill/Present").observe(DataEventType.value) { (DataSnapshot) in
                if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                    self.bills.removeAll()
                    for snap in snapshort {
                        let id = snap.key
                        if let value = snap.value as? [String: Any] {
                            let detilbill = value["detilbill"] as! String
                            let numbertable = value["numbertable"] as! String
                            let status = value["status"] as! Int
                            let total = value["total"] as! Int
                            let date = value["date"] as! String
                            let bill = Bill(id: id, numberTable: numbertable, detailFood: detilbill, Total: total , date: date)
                            self.bills.append(bill)
                            print(detilbill)
                        }
                    }
                }
                self.tableView.reloadData()
            }
    }
    
}

extension BillViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BillCell.loadCell(tableView) as! BillCell
        cell.setUpData(data: bills[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailBillViewController") as! DetailBillViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        let detailBill = bills[indexPath.row]
        vc.amount = detailBill.Total ?? 0
        vc.detailFood = detailBill.detailFood ?? ""
        vc.date = detailBill.date ?? ""
        vc.numberTb = detailBill.id ?? ""
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
