//
//  DetailBillViewController.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 11/12/20.
//

import UIKit
import  Firebase

class DetailBillViewController: UIViewController {
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblDetailFood: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var numberTable: UILabel!
    var detailFood = ""
    var amount = 0
    var date = ""
    var numberTb = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView()
        setDataBill()
        getDataBill()
    }
    
    func customView(){
        subView.layer.borderWidth = 1
        subView.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        subView.layer.cornerRadius = 5
        subView.layer.shadowRadius = 5
        subView.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    func setDataBill() {
        lblDetailFood.text = detailFood
        lblAmount.text = String(amount)
        lblDate.text = date
        numberTable.text = "Bàn số: \(numberTb)"
    }
    
    func getDataBill(){
        Defined.ref.child("Bill/Present").observe(DataEventType.value) { [self] (DataSnapshot) in
                if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                   
                    for snap in snapshort {
                        let id = snap.key
                        if let value = snap.value as? [String: Any] {
                            let detilbill = value["detilbill"] as! String
                            let total = value["total"] as! Int
                            let date = value["date"] as! String
                            
                            if id == self.numberTb{
                                self.lblDetailFood.text = detilbill
                                self.lblDate.text = date
                                self.lblAmount.text = String(total)
                                billDone()
                                
                            }
                        }
                    }
                }
            }
    }
    
    func billDone(){
        let billDone = [
            "detilbill": detailFood ,
            "total": amount,
            "date":date,
            "numbertable":numberTb,] as [String: Any]
        Defined.ref.child("Bill/Done").childByAutoId().setValue(billDone)
    }
    
    func billPay()  {
        Defined.ref.child("Bill/Present/\(Int(self.numberTb) ?? 0)").removeValue { (error, reference) in
            if error != nil {
                print("Error: \(error!)")
            } else {
                print(reference)
                print("Remove successfully")
                Defined.ref.child("Table/\(Int(self.numberTb) ?? 0)").updateChildValues(["statu": 1])
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnPay(_ sender: Any) {
        billDone()
        billPay()
    }
    
    @IBAction func btnScanBill(_ sender: Any) {
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfo.OutputType.general
        printInfo.jobName = "aa"
        printController.printInfo = printInfo
        printController.printingItem = subView.toImage()
        printController.present(animated: true, completionHandler: nil)
    }
}

extension UIView {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
