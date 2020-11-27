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
    
    @IBOutlet weak var inageCartNill: UIImageView!
    @IBOutlet weak var btnAddFood: UIBarButtonItem!
    @IBOutlet weak var lblTable: UITextField!
    @IBOutlet weak var lblNameCustoms: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTotal: UILabel!
    
    var carts = [Cart]()
    var idTable = ""
    var amount = 0
    var listFood = ""
    var idCart = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CartCell.registerCellByNib(tableView)
        getDataCart()
        inageCartNill.isHidden = true
    }
    
  
    
    func dateFormatTime(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
        
    }
    
    func getDataCart(){
        Defined.ref.child("Table/\(Int(idTable) ?? 0)/ListFood").observe(DataEventType.value) { (DataSnapshot) in
            self.carts.removeAll()
            self.amount = 0
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshort {
                    let id = snap.key
                    self.idCart = Int(id) ?? 0
                    if let value = snap.value as? [String: Any] {
                        let namefood = value["namefood"] as! String
                        let imagefood = value["imagefood"] as! String
                        let countfood = value["countfood"] as! Int
                        let pricefood = value["pricefood"] as! Int
                        let cart = Cart(id: id, count: countfood, image: imagefood, name: namefood, price: pricefood)
                        self.carts.append(cart)
                        self.amount += pricefood
                        self.listFood += namefood + "x" + String(countfood) + "  "
                        print(self.listFood)
                        self.lblTotal.text = "Giá Tiền: " + String(self.amount) + " VNĐ"
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func btnOder(_ sender: Any) {
        if (amount == 0){
            let alert = UIAlertController(title: "Gomo ", message: "Giỏ hàng của bạn vẫn còn trống", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let dateThis = dateFormatTime(date: Date())
            let cartDict = [
                "detilbill": listFood ,
                "total": amount,
                "status": 0,
                "date":dateThis,
                "numbertable":self.idTable,] as [String: Any]
            Defined.ref.child("Bill/Present/\(Int(self.idTable) ?? 0)").setValue(cartDict)
            Defined.ref.child("Table/\(Int(self.idTable) ?? 0)").updateChildValues(["statu": 3])
            print(amount)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnDeleteCart(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Cart", message: "Are you sure to delete this cart?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            Defined.ref.child("Table/\(Int(self.idTable) ?? 0)/ListFood").removeValue { (error, reference) in
                if error != nil {
                    print("Error: \(error!)")
                } else {
                    print("Remove successfully")
                    Defined.ref.child("Table/\(Int(self.idTable) ?? 0)").updateChildValues(["statu": 1])
                    self.navigationController?.popViewController(animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailFoodControlerViewController") as! DetailFoodControlerViewController
        let m = carts[indexPath.row]
        vc.ImgFood = m.image ?? ""
        vc.NameFood = m.name ?? ""
        vc.PriceFood = m.price ?? 1
        vc.idTable = idTable
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            }
        }
    }
    

