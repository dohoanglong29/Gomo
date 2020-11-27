//
//  DetailFoodControlerViewController.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 10/23/20.
//

import UIKit
import Firebase
import SDWebImage

class DetailFoodControlerViewController: UIViewController {
    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var lblFood: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblSoLuong: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnCong: UIButton!
    @IBOutlet weak var btnTru: UIButton!
    
    
    var ImgFood = ""
    var NameFood = ""
    var PriceFood:Int = 1
    var NoteFood = ""
    var NumberCount = 1
    var idTable = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        customsButton()
    }
    
    func customsButton(){
        subView.layer.cornerRadius = 5
        btnTru.layer.cornerRadius = 17
        btnCong.layer.cornerRadius = 17
        btnTru.layer.borderWidth = 0.7
        btnCong.layer.borderWidth = 0.7
    }
    
    func setUp(){
        Defined.formatter.groupingSeparator = "."
        Defined.formatter.numberStyle = .decimal
        imageFood.sd_setImage(with: URL(string: ImgFood ), completed: nil)
        lblFood.text = NameFood
        lblNote.text = NoteFood
        lblPrice.text = "\(Defined.formatter.string(from: NSNumber(value: PriceFood ))!)" + " VNĐ"
        lblCount.text = String(NumberCount)
        lblTotal.text = "\(Defined.formatter.string(from: NSNumber(value: PriceFood ))!)" + " VNĐ"
      
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
        //lblTotal.text = String(NumberCount * PriceFood) + " VNĐ"
        lblSoLuong.text = "Số Lượng: \(NumberCount)"
        lblTotal.text = "\(Defined.formatter.string(from: NSNumber(value: NumberCount * PriceFood ))!)" + " VNĐ"
    }
    
    
    @IBAction func btnAddCart(_ sender: Any) {
        let writeData: [String: Any] = [
            "namefood": NameFood,
            "countfood": NumberCount,
            "pricefood": NumberCount * PriceFood,
            "imagefood": ImgFood]
        Defined.ref.child("Table/\(Int(idTable) ?? 0)/ListFood").childByAutoId().setValue(writeData)
        self.dismiss(animated: true, completion: nil)
        
        
    }
}
