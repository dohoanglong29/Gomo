//
//  EditFoodCartViewcontroler.swift
//  GomoApp
//
//  Created by Vương Toàn Bắc on 12/16/20.
//

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
    var  idCartFood = ""
    var namef = ""
    var imagef = ""
    var pricef = 0
    var prices = 0
    var idTable = ""
    var counts = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
    }
    
    func setUpData() {
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal
        imageFood.sd_setImage(with: URL(string: imagef), completed: nil)
        lblNameFood.text = namef
        lblPriceFood.text = String(pricef/countFood)
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
        lblTotal.text = "Tổng tiền: \(Defined.formatter.string(from: NSNumber(value: NumberCount * pricef ))!)" + " VNĐ"
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
            "countfood": Int(lblCountFood.text ?? ""),
            "imagefood": imagef,
            "namefood": namef,
            "pricefood":prices ,] as [String: Any]
        Defined.ref.child("Account").child(Constans.idAdmin).child("Table").child("\(self.idTable)").child("ListFood/\(idCartFood)").updateChildValues(setUpFood)
        self.dismiss(animated: true, completion: nil)
    }
}
