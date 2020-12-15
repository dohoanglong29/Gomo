//
//  CartViewController.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 10/24/20.
//

import UIKit
import Firebase
import RxSwift

class CartViewController: UIViewController {
    
    @IBOutlet weak var btnAddFood: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTotal: UILabel!
    
    let curentDateTime = Date()
    var carts = [Cart]()
    var idTable = ""
    var amount = 0
    var statustable = ""
    var listFood = ""
    var listPriceFood = ""
    var idCart = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CartCell.registerCellByNib(tableView)
        getDataCart()
    }
    
    func dateFormatTime(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getDataCart(){
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal

        Defined.ref.child("Account").child(Constans.idAdmin).child("Table/\(Int(idTable) ?? 0)/ListFood").observe(DataEventType.value) { [self] (DataSnapshot) in
            self.carts.removeAll()
            self.amount = 0
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshort {
                    let id = snap.key
                    if let value = snap.value as? [String: Any] {
                        let namefood = value["namefood"] as! String
                        let imagefood = value["imagefood"] as! String
                        let countfood = value["countfood"] as! Int
                        let pricefood = value["pricefood"] as! Int
                        let cart = Cart(id: id, count: countfood, image: imagefood, name: namefood, price: pricefood)
                        self.carts.append(cart)
                        self.amount += pricefood
                        self.idCart = id
                        self.listPriceFood += String(pricefood) + "/"
                        self.listFood += namefood + "x " + String(countfood) + " x " + String(pricefood/countfood)  +  "/"
                        self.lblTotal.text = "Giá Tiền: " + "\(Defined.formatter.string(from: NSNumber(value: self.amount ))!)" + " VNĐ"
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func btnOder(_ sender: Any) {
        if (amount == 0){
            self.showDialog(title: Constans.notification, message: "Giỏ hàng của bạn vẫn còn trống")
        }else{
            let dateThis = dateFormatTime(date: Date())
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm dd/MM/yyyy"
            let someDateTime = formatter.string(from: curentDateTime)
            

            let cartDict = [
                "detilbill": listFood,
                "listpricefood": listPriceFood,
                "total": amount,
                "status": 0,
                "date":dateThis,
                "time":someDateTime,
                "numbertable":self.idTable,] as [String: Any]
            Defined.ref.child("Account").child(Constans.idAdmin).child("Bill/Present/\(Int(self.idTable) ?? 0)").setValue(cartDict)
            Defined.ref.child("Account").child(Constans.idAdmin).child("Table/\(Int(self.idTable) ?? 0)").updateChildValues(["statu": 3])
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnDeleteCart(_ sender: Any) {
        let alert = UIAlertController(title: "Gomo", message: "Bạn có muốn xoá giỏ hàng?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Đóng ", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Xoá ", style: .default, handler: { action in
            Defined.ref.child("Account").child(Constans.idAdmin).child("Table/\(Int(self.idTable) ?? 0)/ListFood").removeValue { (error, reference) in
                if error != nil {
                    print("Error: \(error!)")
                } else {
                    Defined.ref.child("Account").child(Constans.idAdmin).child("Table/\(Int(self.idTable) ?? 0)").updateChildValues(["statu": 1])
                    
                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                    
                    if self.statustable == "1"{
                        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                    }else{
                        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
                    }
                }
            }
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func btnAddFood(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.idTable = idTable
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func showDialog(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                        switch action.style{
                                        case .default: break
                                        case .cancel: break
                                        case .destructive: break
                                        }}))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CartCell.loadCell(tableView) as! CartCell
        cell.setUpData(data: carts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Xoá ") { [self] (action, indexPath) in
            let c = self.carts[indexPath.row]
            Defined.ref.child("Account").child(Constans.idAdmin).child("Table").child("\(self.idTable)").child("ListFood").removeValue { (error, reference) in}
        }
        let share = UITableViewRowAction(style: .normal, title: "Sửa") { (action, indexPath) in
        }
        share.backgroundColor = UIColor.blue

        return [delete, share]
    }
}



    

