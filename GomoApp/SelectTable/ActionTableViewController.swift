//
//  ActionTableViewController.swift
//  GomoApp
//
//  Created by BAC Vuong Toan (VTI.Intern) on 12/10/20.
//

import UIKit
import Firebase

class ActionTableViewController: UIViewController {

    @IBOutlet weak var txtSelectTable: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var subView: UIView!
    
    var mergeTable = [String]()
    var changeTabe = [String]()
    var selectCard: String?
    var idTable = ""
    var idTableThis = ""
    var amount1 = 0
    var listFood1 = ""
    var amount2 = 0
    var listFood2 = ""
    var dateThis = ""
    var timeThis = ""
    var listpricefood1 = ""
    var listpricefood2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        createPickerView()
        dismissPickerView()
        getNumberTable()
        getDataCart()
        getDataBill()
    }
    
    func setUpView(){
        subView.layer.cornerRadius = 10
        subView.layer.borderWidth = 1
        btnConfirm.layer.cornerRadius = 7
    }

    
    @IBAction func btnConfirm(_ sender: Any) {
        
        
        if idTable == txtSelectTable.text{
            self.showDialog(title: Constans.notification, message: Constans.selectTable)
        }else{
            getDataBill()
            let merge = [
                "detilbill": listFood1 + listFood2,
                "listpricefood": listpricefood1 + listpricefood2 ,
                "total": amount1 + amount2,
                "date":dateThis,
                "time": timeThis,
                "numbertable":idTableThis,] as [String: Any]
            Defined.ref.child("Account").child(Constans.idAdmin).child("Bill/Present").child("/\(idTableThis)").updateChildValues(merge)
            Defined.ref.child("Account").child(Constans.idAdmin).child("Table").child(self.idTable).child("ListFood").removeValue()
            Defined.ref.child("Account").child(Constans.idAdmin).child("Bill/Present/\(Int(idTable) ?? 0)").removeValue { (error, reference) in
                if error != nil {
                    print(error as Any)
                } else {
                    Defined.ref.child("Account").child(Constans.idAdmin).child("Table/\(Int(self.idTable) ?? 0)").updateChildValues(["statu": 1])
                    self.dismiss(animated: true, completion: nil)

                }
            }
            
        }
    }
    
    // lấy hoá đơn của bàn gộp
    func getDataBill(){
        Defined.ref.child("Account").child(Constans.idAdmin).child("Bill/Present").observe(DataEventType.value) { [self] (DataSnapshot) in
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshort {
                    let id = snap.key
                    if let value = snap.value as? [String: Any] {
                        let date = value["date"] as! String
                        let detilbill = value["detilbill"] as! String
                        let listpricefood = value["listpricefood"] as? String
                        let total = value["total"] as! Int
                        let time = value["time"] as! String
                        
                        let idtableThat = txtSelectTable.text
                        // lấy thông tin của bàn được chọn
                        if id == idtableThat {
                            self.listpricefood2 = listpricefood ?? ""
                            print("backol\(listpricefood2)")
                            self.amount2 = total
                            self.listFood2 = detilbill
                            self.dateThis = date
                            self.timeThis = time
                            idTableThis = idtableThat ?? ""
                        }
                    }
                }
            }
        }
    }
    
    // lấy hoá đơn của bàn gộp bị gộp
    func getDataCart(){
        Defined.ref.child("Account").child(Constans.idAdmin).child("Table/\(Int(idTable) ?? 0)/ListFood").observe(DataEventType.value) { (DataSnapshot) in
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshort {
                    _ = snap.key
                    if let value = snap.value as? [String: Any] {
                        let namefood = value["namefood"] as! String
                        let countfood = value["countfood"] as! Int
                        let pricefood = value["pricefood"] as! Int
                        // lấy tiền và danh sách món ăn
                        self.listpricefood1 += String(pricefood) + "/"
                        print("backol2\(self.listpricefood1)")
                        self.amount1 += pricefood
                        self.listFood1 += namefood + "x " + String(countfood) + " x " + String(pricefood/countfood)  + "/"
                    }
                }
            }
        }
    }
    
    // lấy tất cả bản đã có hoá đơn
    func getNumberTable(){
        Defined.ref.child("Account").child(Constans.idAdmin).child("Table").observe(DataEventType.value) { (DataSnapshot) in
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshort {
                    _ = snap.key
                    if let value = snap.value as? [String: Any] {
                        let statu = value["statu"] as! Int
                        let numberTable = value["NumberTable"] as! Int
                        if statu == 3{
                            self.mergeTable.append(String(numberTable))
                        }else{
                            print("chưa có data")
                        }
                    }
                }
            }
        }
    }
    
    
    // tạo Pickerview
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtSelectTable.inputView = pickerView
    }
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(
            title: "OK",
            style: .plain,
            target: self,
            action: #selector(action(sender:))
        )
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtSelectTable.inputAccessoryView = toolBar
        
    }
    @objc func action(sender: UIBarButtonItem) {
        view.endEditing(true)
        txtSelectTable.isEnabled = true;
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

extension ActionTableViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return mergeTable.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return mergeTable[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectCard = mergeTable[row]
        txtSelectTable.text = selectCard
        getDataBill()
        
    }
    
    
}
