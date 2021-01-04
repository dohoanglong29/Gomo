

import UIKit
import Firebase

class CartViewController: UIViewController {
    
    @IBOutlet weak var btnAddFood: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTotal: UILabel!
        
    let curentDateTime = Date()
    var carts = [Cart]()
    var idTable = ""
    var status = 0
    var amount = 0
    var statustable = ""
    var listFood = ""
    var listPriceFood = ""
    var idCart = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CartCell.registerCellByNib(tableView)
        getDataCart()
        tableView.reloadData()
    }

    func getDataCart(){
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(idTable) ?? 0)/ListFood").observe(DataEventType.value) { [self] (DataSnapshot) in
            self.carts.removeAll()
            listFood =  ""
            listPriceFood = ""
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
        let dateThis = FormatDay(date: Date())
        let someDateTime = FormatTime(time: curentDateTime)
        let cartDict = [
            "detilbill": listFood,
            "listpricefood": listPriceFood,
            "total": amount,
            "status": 0,
            "date":dateThis,
            "time":someDateTime,
            "numbertable":self.idTable,] as [String: Any]
            Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(self.idTable) ?? 0)").updateChildValues(["statu": 3])
            Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Bill/Present/\(Int(self.idTable) ?? 0)").updateChildValues(cartDict)
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func btnDeleteCart(_ sender: Any) {
        AlertUtil.actionAlert(from: self, with: Constans.notification, message: Constans.deleteCart) { (ac) in
            Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(self.idTable) ?? 0)/ListFood").removeValue { (error, reference) in
                if error != nil {
                    print("Error: \(error!)")
                } else {
                    Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(self.idTable) ?? 0)").updateChildValues(["statu": 1])
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let c = self.carts[indexPath.row]
        let delete = UITableViewRowAction(style: .destructive, title: "Xoá ") { [self] (action, indexPath) in
            Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table").child("\(self.idTable)").child("ListFood/\(c.id ?? "")").removeValue { (error, reference) in}
            print("delete\(c.id ?? "")")
        }
        let share = UITableViewRowAction(style: .normal, title: "Sửa") { (action, indexPath) in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditFoodCartViewcontroler") as! EditFoodCartViewcontroler
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.namef = c.name ?? ""
            vc.imagef = c.image ?? ""
            vc.pricef = c.price ?? 0
            vc.idCartFood = c.id ?? ""
            vc.idTable = self.idTable
            vc.countFood = c.count ?? 0
            self.present(vc, animated: true, completion: nil)
        }
        share.backgroundColor = UIColor.blue
        return [delete, share]
    }
}



    

