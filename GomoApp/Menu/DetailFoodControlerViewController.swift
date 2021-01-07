

import UIKit
import Firebase
import SDWebImage

class DetailFoodControlerViewController: UIViewController {
    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var lblFood: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var btnCong: UIButton!
    @IBOutlet weak var btnTru: UIButton!
    @IBOutlet weak var btnAddFood: UIButton!
    @IBOutlet weak var txtNoteFood: UITextField!
    
    var resetfood = ""
    var ImgFood = ""
    var NameFood = ""
    var PriceFood:Int = 1
    var NoteFood = ""
    var NumberCount = 1
    var idTable = ""
    var unifyFood = ""
    var unifyCount = 1
    var unifyPrice = 1
    var unifyId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        customsButton()
        getFoodsData()
    }
    
    func customsButton(){
        subView.addShadow(radius: 5)
        btnTru.addBoder(radius: 17, color: #colorLiteral(red: 0.4039215686, green: 0.8039215686, blue: 1, alpha: 1))
        btnCong.addBoder(radius: 17, color: #colorLiteral(red: 0.4039215686, green: 0.8039215686, blue: 1, alpha: 1))
        btnAddFood.addBoder(radius: 10, color: #colorLiteral(red: 0.4039215686, green: 0.8039215686, blue: 1, alpha: 1))
    }
    
    func setUp(){
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal
        imageFood.sd_setImage(with: URL(string: ImgFood ), completed: nil)
        lblFood.text = NameFood
        lblNote.text = NoteFood
        lblPrice.text = "\(Defined.formatter.string(from: NSNumber(value: PriceFood ))!)" + " đ"
        lblCount.text = String(NumberCount)
        btnAddFood.setTitle(" Thêm vào giỏ hàng - \(Defined.formatter.string(from: NSNumber(value: NumberCount * PriceFood ))!)" + " đ", for: .normal)
      
    }
    
    func getFoodsData(){
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(idTable) ?? 0)/ListFood").observe(DataEventType.value) { (DataSnapshot) in
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshort {
                    let id = snap.key
                    if let value = snap.value as? [String: Any] {
                        let namefood = value["namefood"] as! String
                        let countfood = value["countfood"] as! Int
                        let pricefood = value["pricefood"] as! Int
                        if namefood == self.NameFood{
                            self.unifyFood = namefood
                            self.unifyId = id
                            self.unifyCount = countfood
                            self.unifyPrice = pricefood
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnIncrease(_ sender: Any) {
        if NumberCount > 9{
            print("aa")
        }else{
            NumberCount += 1
            setUpDetailMenu()
        }
        
    }
    
    @IBAction func btnReduction(_ sender: Any) {
        if NumberCount < 2{
            NumberCount = 1
            setUpDetailMenu()
        }else{
            NumberCount -= 1
            setUpDetailMenu()
        }
    }
    
    func setUpDetailMenu() {
        lblCount.text = String(NumberCount)
        btnAddFood.setTitle(" Thêm vào giỏ hàng - \(Defined.formatter.string(from: NSNumber(value: NumberCount * PriceFood ))!)" + " đ", for: .normal)
    }
    
    
    @IBAction func btnAddCart(_ sender: Any) {
        
        if unifyFood == NameFood{
            let writeData: [String: Any] = [
                "notefood": txtNoteFood.text ?? "",
                "namefood": NameFood,
                "countfood": NumberCount + unifyCount,
                "pricefood": NumberCount * PriceFood + unifyPrice,
                "imagefood": ImgFood]
            Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(idTable) ?? 0)/ListFood").child(unifyId).updateChildValues(writeData)
            self.dismiss(animated: true, completion: nil)
        }else{
            let writeData: [String: Any] = [
                "notefood": txtNoteFood.text ?? "",
                "namefood": NameFood,
                "countfood": NumberCount,
                "pricefood": NumberCount * PriceFood,
                "imagefood": ImgFood]
            Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(idTable) ?? 0)/ListFood").childByAutoId().setValue(writeData)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
