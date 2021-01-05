//
//  BillViewController.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 11/12/20.
//

import UIKit
import Firebase
import BetterSegmentedControl

class BillViewController: UIViewController {
    @IBOutlet weak var segmentedCustom: BetterSegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var bills = [Bill]()
    var status = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBillPresent()
        initComponent()
    }
    
    func initComponent(){
        BillCell.registerCellByNib(tableView)
        segmentedCustom.segments = LabelSegment.segments(
            withTitles:[Constans.billThis,Constans.billThat],
            normalTextColor: #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1),selectedTextColor: #colorLiteral(red: 0.9254901961, green: 0.9568627451, blue: 0.9921568627, alpha: 1))
        status = "0"
    }
    
    func getBillPresent(){
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Bill/Present").observe(DataEventType.value) { (DataSnapshot) in
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
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Bill/Done").observe(DataEventType.value) { (DataSnapshot) in
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
                        let discount = value["discount"] as? String
                        let totalPay = value["totalpay"] as? Int
                        let bill = Bill(id: id, numberTable: numbertable, detailFood:detilbill, Total: total, date: date, discouunt: discount, time: time, listpricefood: listpricefood, totalPay: totalPay)
                        self.bills.append(bill)
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func btnSegmentBill(_ sender: BetterSegmentedControl) {
        if sender.index == 0{
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
        cell.selectionStyle = .none
        cell.setUpData(data: bills[indexPath.row], s:status)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constans.detailBill) as! DetailBillViewController
        let detailBill = bills[indexPath.row]
        vc.amount = detailBill.Total ?? 0
        vc.detailFood = detailBill.detailFood ?? ""
        vc.date = detailBill.date ?? ""
        vc.time = detailBill.time ?? ""
        vc.numberTb = detailBill.numberTable ?? ""
        vc.status = status
        vc.discount1 = detailBill.discouunt ?? ""
        vc.listpricefood = detailBill.listpricefood ?? ""
        vc.totalPay1 = detailBill.totalPay ?? 0
        self.present(vc, animated: true, completion: nil)
    }
}

