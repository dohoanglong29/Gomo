//
//  DetailBillViewController.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 11/12/20.
//

import UIKit
import  Firebase

class DetailBillViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblCollector: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnPay1: UIButton!
    @IBOutlet weak var numberTable: UILabel!
    var listFood:[String] = []
    var listPrice:[Int] = []
    var detailFood = ""
    var amount = 0
    var date = ""
    var numberTb = ""
    var status = ""
    var time = ""
    var listpricefood = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView()
        setDataBill()
        setUp()
    }
    
    func customView(){
        subView.layer.borderWidth = 1
        subView.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        subView.layer.cornerRadius = 5
        subView.layer.shadowRadius = 5
        subView.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    func setUp(){
        DetailFoodCell.registerCellByNib(tableView)
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal
        lblCollector.text = Defined.defaults.value(forKey: "name") as? String
        let tempfood = self.detailFood.split{$0 == "/"}.map(String.init)
        let tempPrice = self.listpricefood.split{$0 == "/"}.map(String.init)
        
        for i in 0..<tempfood.count{
            self.listFood.append(tempfood[i])
        }
        for i in 0..<tempPrice.count{
            self.listPrice.append(Int(tempPrice[i]) ?? 0)
        }
        let total = listPrice.reduce(0, +)
        print("asas\(total)")
        lblAmount.text = "\(Defined.formatter.string(from: NSNumber(value: total ))!)" + " VNĐ"
        lblDate.text = date
        numberTable.text = "Bàn số: \(numberTb)"
    }
    
    func setDataBill() {
        if status == "1"{
            btnPay1.isEnabled = false
        }else{
            btnPay1.isEnabled = true
        }
        
    }
    func billDone(){
        let billDone = [
            "detilbill": detailFood ,
            "total": amount,
            "date":date,
            "time": time,
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
extension DetailBillViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFood.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DetailFoodCell.loadCell(tableView) as! DetailFoodCell
        let fo = listFood[indexPath.row]
        cell.setUp(name: fo)
        return cell
    }
   
}

