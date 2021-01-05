import UIKit
import Firebase

class DetailBillViewController: UIViewController {
    @IBOutlet weak var txtChiecKhau: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblCollector: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnPay1: UIButton!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var numberTable: UILabel!
    @IBOutlet weak var lblTotalPay: UILabel!
    
    var listFood:[String] = []
    var listPrice:[Int] = []
    var select: String?
    var phamTram = ["0","5","10","15","20","25","30","35","40","45","50"]
    
    
    var detailFood = ""
    var amount = 0
    var discount = 0
    var totalPayInDiscount = 0
    var totalPay = 0
    var date = ""
    var numberTb = ""
    var status = ""
    var time = ""
    var listpricefood = ""
    var moneyMinus = 0
    var discount1 = ""
    var totalPay1 = 0
    var money = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        dismissPickerView()
        customView()
        setDataBill()
        setUp()
    }
    
    func customView(){
        subView.addShadow(radius: 5)
        subView.addBoder(radius: 10, color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
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
        lblAmount.text = "\(Defined.formatter.string(from: NSNumber(value: total ))!)" + " đ"
        lblDate.text = time
        numberTable.text = "Bàn số: \(numberTb)"
        totalPayInDiscount = total - moneyMinus
        txtChiecKhau.text = discount1
        
        if status == "1"{
            lblTotalPay.text = String(totalPay1)
        }else{
            lblTotalPay.text = String(total)
        }
    }
    
    func setDataBill() {
        if status == "1"{
            btnPay1.isEnabled = false
            txtChiecKhau.isEnabled = false
        }else{
            btnPay1.isEnabled = true
        }
        
    }
    func billDone(){
        if let strAmount = lblTotalPay.text,
           let intAmount = Int(strAmount){
            money = intAmount
        }
        let total = listPrice.reduce(0, +)
        let billDone = [
            "detilbill": detailFood ,
            "listpricefood": listpricefood ,
            "total": total,
            "discount": txtChiecKhau.text ?? "",
            "time":time,
            "date":date,
            "totalpay": money,
            "numbertable":numberTb,] as [String: Any]
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Bill/Done").childByAutoId().setValue(billDone)
    }
    
    func billPay()  {
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Bill/Present/\(Int(self.numberTb) ?? 0)").removeValue { (error, reference) in
            if error != nil {
                
            } else {
                Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table").child(self.numberTb).child("ListFood").removeValue()
                Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(self.numberTb) ?? 0)").updateChildValues(["statu": 1])
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
        printInfo.jobName = "print"
        printController.printInfo = printInfo
        printController.printingItem = subView.toImage()
        printController.present(animated: true, completionHandler: nil)
    }
    // tạo Pickerview
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtChiecKhau.inputView = pickerView
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
        txtChiecKhau.inputAccessoryView = toolBar
        
    }
    @objc func action(sender: UIBarButtonItem) {
        view.endEditing(true)
        txtChiecKhau.isEnabled = true;
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
        let pr = listPrice[indexPath.row]
        cell.setUp(name: fo, price: pr)
        return cell
    }
}

extension DetailBillViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return phamTram.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return phamTram[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        select = phamTram[row]
        txtChiecKhau.text = String("\(select ?? "")" + "%")
        if let strAmount = select,
           let intAmount = Int(strAmount) {
            discount = intAmount }
        let abc = totalPayInDiscount * discount/100
        lblTotalPay.text = String(totalPayInDiscount  - abc)
    }
}

