

import UIKit
import SDWebImage

class EditFoodCartViewcontroler: UIViewController {
    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSetUp: UIButton!
    @IBOutlet weak var lblNameFood: UILabel!
    @IBOutlet weak var lblPriceFood: UILabel!
    @IBOutlet weak var btnCong: UIButton!
    @IBOutlet weak var btnTru: UIButton!
    @IBOutlet weak var lblCountFood: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    var NumberCount = 1
    var countFood = 0
    var idCartFood = ""
    var namef = ""
    var imagef = ""
    var pricef = 0
    var prices = 0
    var idTable = ""
    var counts = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUPView()
    }
    
    func setUpData() {
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal
        imageFood.sd_setImage(with: URL(string: imagef), completed: nil)
        lblNameFood.text = namef
        lblPriceFood.text = String(pricef/countFood)
        lblTotal.text = String(pricef/countFood)
    }
    
    func setUPView(){
        imageFood.layer.cornerRadius = 20
        subView.layer.cornerRadius = 20
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOpacity = 0.6
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = 10
        btnTru.layer.cornerRadius = btnTru.bounds.size.height/2
        btnCong.layer.cornerRadius = btnTru.bounds.size.height/2
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
            print("aa")
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
            "imagefood": imagef,
            "namefood": namef,
            "pricefood":prices,] as [String: Any]
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table").child("\(self.idTable)").child("ListFood/\(idCartFood)").updateChildValues(setUpFood)
        self.dismiss(animated: true, completion: nil)
    }
}
