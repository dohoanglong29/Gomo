

import UIKit
import SDWebImage

class EditFoodCartViewcontroler: UIViewController {
    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var btnSetUp: UIButton!
    @IBOutlet weak var lblNameFood: UILabel!
    @IBOutlet weak var lblPriceFood: UILabel!
    @IBOutlet weak var btnCong: UIButton!
    @IBOutlet weak var btnTru: UIButton!
    @IBOutlet weak var lblCountFood: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var lblNoteFood: UITextField!
    
    var NumberCount = 1
    var countFood = 0
    var pricef = 0
    var prices = 0
    var counts = 0
    var idTable = ""
    var idCartFood = ""
    var namef = ""
    var imagef = ""
    var nodefood = ""
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        setUPView()
    }
    
    func initComponent() {
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal
        imageFood.sd_setImage(with: URL(string: imagef), completed: nil)
        lblNameFood.text = namef
        lblPriceFood.text = String(pricef/countFood) + " đ"
        lblTotal.text = String(pricef/countFood) 
        lblNoteFood.text = nodefood
    }
    
    func setUPView(){
        subView2.addShadow(radius: 5)
        subView.addShadow(radius: 5)
        imageFood.addBoder(radius: 15, color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
        subView.addBoder(radius: 20, color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
        subView2.addBoder(radius: 20, color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
        btnTru.addBoder(radius: btnTru.bounds.size.height/2, color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
        btnCong.addBoder(radius: btnTru.bounds.size.height/2, color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
        btnSetUp.addBoder(radius: 20, color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
    }
    
    @IBAction func btnTru(_ sender: Any) {
        if NumberCount < 2{
            NumberCount = 1
            setUpDetailMenu()
        }else{
            NumberCount -= 1
            setUpDetailMenu()
        }
    }
    
    @IBAction func btnCong(_ sender: Any) {
        if NumberCount > 9{
        }else{
            NumberCount += 1
            setUpDetailMenu()
        }
    }
    
    func setUpDetailMenu() {
        lblCountFood.text = String(NumberCount)
        lblTotal.text = String(NumberCount * pricef/countFood)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSetUp(_ sender: Any) {
        if let strPrice = lblTotal.text,
           let intPrice = Int(strPrice){
            prices = intPrice
        }
        let setUpFood = [
            "countfood": Int(lblCountFood.text ?? "") as Any,
            "notefood": lblNoteFood.text ?? "",
            "imagefood": imagef,
            "namefood": namef,
            "pricefood":prices,] as [String: Any]
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table").child("\(self.idTable)").child("ListFood/\(idCartFood)").updateChildValues(setUpFood)
        self.dismiss(animated: true, completion: nil)
    }
}
