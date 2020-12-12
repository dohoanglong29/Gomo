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
    var status = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BillCell.registerCellByNib(tableView)
        getBillPresent()
        status = "0"
        
    }
    
    func getBillPresent(){
        Defined.ref.child("Bill/Present").observe(DataEventType.value) { (DataSnapshot) in
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                self.bills.removeAll()
                for snap in snapshort {
                    let id = snap.key
                    if let value = snap.value as? [String: Any] {
                        let date = value["date"] as! String
                        let detilbill = value["detilbill"] as! String
                        let numbertable = value["numbertable"] as! String
                        let listpricefood = value["listpricefood"] as? String
                        let total = value["total"] as! Int
                        let time = value["time"] as! String
                        let bill = Bill(id: id,numberTable: numbertable, detailFood: detilbill, Total: total, date: date ,time: time,listpricefood: listpricefood)
                        self.bills.append(bill)
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func getBillDone(){
        Defined.ref.child("Bill/Done").observe(DataEventType.value) { (DataSnapshot) in
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                self.bills.removeAll()
                for snap in snapshort {
                    let id = snap.key
                    if let value = snap.value as? [String: Any] {
                        let date = value["date"] as! String
                        let detilbill = value["detilbill"] as! String
                        let listpricefood = value["listpricefood"] as? String
                        let numbertable = value["numbertable"] as! String
                        let total = value["total"] as! Int
                        let time = value["time"] as? String
                        let bill = Bill(id: id,numberTable: numbertable, detailFood: detilbill, Total: total, date: date, time: time,listpricefood: listpricefood)
                        self.bills.append(bill)
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    
    
    
    @IBAction func btnSelectBill(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            getBillPresent()
            status = "0"
        }else{
            getBillDone()
            status = "1"
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
        let detailBill = bills[indexPath.row]
        vc.amount = detailBill.Total ?? 0
        vc.detailFood = detailBill.detailFood ?? ""
        vc.date = detailBill.time ?? ""
        vc.numberTb = detailBill.id ?? ""
        vc.status = status
        vc.time = detailBill.time ?? ""
        vc.listpricefood = detailBill.listpricefood ?? ""
        self.present(vc, animated: true, completion: nil)
    }
}

